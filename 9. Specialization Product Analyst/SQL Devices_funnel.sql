WITH unique_events AS (
  SELECT
    event_name,
    user_pseudo_id,
    country,
    category, 
    event_timestamp,
    ROW_NUMBER() OVER (PARTITION BY event_name, user_pseudo_id ORDER BY event_timestamp) AS row_num
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
),
filtered_events AS (
  SELECT
    event_name,
    user_pseudo_id,
    country,
    category, 
    event_timestamp
  FROM
    unique_events
  WHERE
    row_num = 1
    AND event_name IN ('page_view', 'user_engagement', 'session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')
),
top_countries AS (
  SELECT
    country,
    COUNT(*) AS event_count
  FROM
    filtered_events
  GROUP BY
    country
  ORDER BY
    event_count DESC
  LIMIT 3
),
event_totals AS (
  SELECT
    fe.event_name,
    fe.country,
    fe.category, 
    COUNT(*) AS event_count
  FROM
    filtered_events fe
  WHERE
    fe.country IN (SELECT country FROM top_countries)
  GROUP BY
    fe.event_name, fe.country, fe.category
)
SELECT
  ROW_NUMBER() OVER (ORDER BY 
    CASE event_totals.event_name
      WHEN 'page_view' THEN 1
      WHEN 'user_engagement' THEN 2
      WHEN 'session_start' THEN 3
      WHEN 'view_item' THEN 4
      WHEN 'add_to_cart' THEN 5
      WHEN 'begin_checkout' THEN 6
      WHEN 'purchase' THEN 7
    END) AS event_order,
  event_totals.event_name,
  event_totals.category, 
  MAX(CASE WHEN top_countries.country = (SELECT country FROM top_countries LIMIT 1 OFFSET 0) THEN event_totals.event_count END) AS `1st Country events`,
  MAX(CASE WHEN top_countries.country = (SELECT country FROM top_countries LIMIT 1 OFFSET 1) THEN event_totals.event_count END) AS `2nd Country events`,
  MAX(CASE WHEN top_countries.country = (SELECT country FROM top_countries LIMIT 1 OFFSET 2) THEN event_totals.event_count END) AS `3rd Country events`
FROM
  event_totals
JOIN
  top_countries ON event_totals.country = top_countries.country
GROUP BY
  event_totals.event_name, event_totals.category
ORDER BY
  event_order, event_totals.category