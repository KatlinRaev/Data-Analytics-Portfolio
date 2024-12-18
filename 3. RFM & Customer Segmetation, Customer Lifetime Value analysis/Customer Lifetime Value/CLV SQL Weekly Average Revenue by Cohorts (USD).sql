WITH reference_date AS (
    SELECT DATE '2021-01-24' AS ref_date
),

-- Get first visit as registration for each user
first_visit AS (
    SELECT
        user_pseudo_id,
        MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS registration_date
    FROM
        `tc-da-1.turing_data_analytics.raw_events`
    GROUP BY
        user_pseudo_id
),

-- Identify weekly cohorts based on the first visit date
weekly_cohorts AS (
    SELECT
        user_pseudo_id,
        registration_date,
        DATE_TRUNC(registration_date, WEEK) AS registration_week
    FROM
        first_visit
),

-- Calculate cohort size by counting distinct users in each cohort
cohort_size AS (
    SELECT
        registration_week,
        COUNT(DISTINCT user_pseudo_id) AS cohort_size,
        MIN(registration_date) AS cohort_start_date
    FROM
        weekly_cohorts
    GROUP BY
        registration_week
),

-- Calculate weekly revenue from purchases for each user and cohort
weekly_revenue AS (
    SELECT
        wc.registration_week,
        DATE(TIMESTAMP_MICROS(re.event_timestamp)) AS event_date,
        SUM(re.purchase_revenue_in_usd) AS total_revenue -- Total revenue for the week
    FROM
        weekly_cohorts wc
    JOIN
        `tc-da-1.turing_data_analytics.raw_events` re
    ON
        wc.user_pseudo_id = re.user_pseudo_id
    WHERE
        re.event_name = 'purchase'
    
    GROUP BY
        wc.registration_week, event_date
)

SELECT
    cs.cohort_start_date AS registration_date,
    cs.cohort_size,
    COALESCE(SUM(CASE WHEN wr.event_date >= cs.cohort_start_date AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 1 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_0,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 1 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 2 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_1,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 2 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 3 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_2,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 3 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 4 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_3,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 4 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 5 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_4,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 5 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 6 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_5,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 6 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 7 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_6,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 7 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 8 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_7,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 8 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 9 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_8,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 9 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 10 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_9,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 10 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 11 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_10,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 11 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 12 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_11,
    COALESCE(SUM(CASE WHEN wr.event_date >= DATE_ADD(cs.cohort_start_date, INTERVAL 12 WEEK) AND wr.event_date < DATE_ADD(cs.cohort_start_date, INTERVAL 13 WEEK) THEN wr.total_revenue ELSE 0 END), 0) / NULLIF(cs.cohort_size, 0) AS week_12

FROM
    cohort_size cs
LEFT JOIN
    weekly_revenue wr ON cs.registration_week = wr.registration_week
GROUP BY
    cs.cohort_start_date, cs.cohort_size
ORDER BY
    cs.cohort_start_date
