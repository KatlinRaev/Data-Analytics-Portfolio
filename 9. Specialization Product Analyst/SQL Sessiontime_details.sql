-- breaks between sessions: Session break length is by default 30 minutes, analyse measures first transaction of the day starting form the purchase session start
-- small proportion (around 3 %) of purchases are missing due midnight shopping (session start is in previous day) or unexpexted user behavior

WITH session_starts AS (
    SELECT
        user_pseudo_id,
        TIMESTAMP_MICROS(event_timestamp) AS session_start_time,
        EXTRACT(DATE FROM TIMESTAMP_MICROS(event_timestamp)) AS session_day
    FROM `turing_data_analytics.raw_events`
    WHERE event_name = 'session_start'
),
purchases AS (
    SELECT
        user_pseudo_id,
        TIMESTAMP_MICROS(event_timestamp) AS purchase_time,
        EXTRACT(DATE FROM TIMESTAMP_MICROS(event_timestamp)) AS purchase_day,
        purchase_revenue_in_usd AS revenue,
        category,
        country,
        operating_system,
        browser,
        transaction_id
    FROM `turing_data_analytics.raw_events`
    WHERE event_name = 'purchase'
),
linked_sessions AS (
    SELECT
        s.user_pseudo_id,
        s.session_start_time,
        p.purchase_time,
        p.purchase_day,
        p.revenue,
        p.category,
        p.country,
        p.operating_system,
        p.browser,
        p.transaction_id,
        COUNT(p.transaction_id) OVER (PARTITION BY s.user_pseudo_id ORDER BY p.purchase_time ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS past_purchases
    FROM session_starts s
    JOIN purchases p
        ON s.user_pseudo_id = p.user_pseudo_id
        AND s.session_start_time <= p.purchase_time
        AND s.session_day = p.purchase_day
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY p.user_pseudo_id, p.purchase_time
        ORDER BY s.session_start_time DESC
    ) = 1
),
first_purchases AS (
    SELECT
        user_pseudo_id,
        MIN(session_start_time) AS first_visit,
        MIN(purchase_time) AS purchase_time,
        ANY_VALUE(revenue) AS revenue,
        ANY_VALUE(category) AS category,
        ANY_VALUE(country) AS country,
        ANY_VALUE(operating_system) AS operating_system,
        ANY_VALUE(browser) AS browser,
        ANY_VALUE(transaction_id) AS transaction_id,
        ANY_VALUE(past_purchases) AS past_purchases
    FROM linked_sessions
    GROUP BY user_pseudo_id, purchase_day
)
SELECT
    user_pseudo_id,
    first_visit,
    purchase_time AS purchase,
    TIMESTAMP_DIFF(purchase_time, first_visit, SECOND) AS seconds_to_purchase,
    category,
    country,
    revenue,
    operating_system,
    browser,
    transaction_id,
    CASE 
        WHEN past_purchases > 0 THEN 1
        ELSE 0
    END AS returning_customer
FROM first_purchases
WHERE revenue IS NOT NULL 
    AND revenue > 0 
    AND transaction_id IS NOT NULL
    AND TIMESTAMP_DIFF(purchase_time, first_visit, SECOND) > 0
ORDER BY seconds_to_purchase