WITH unique_events AS ( -- unique events are captured by timestamp
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY event_name, user_pseudo_id ORDER BY event_timestamp) AS row_num
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
),
filtered_events AS ( --limits the data to specific event names relevant to the funnel analysis
  SELECT
    *
  FROM
    unique_events
  WHERE
    row_num = 1
    AND event_name IN ('page_view', 'user_engagement', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')
),
top_countries AS (  -- Groups the filtered events by country, counting the total events per country.
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
event_totals AS ( -- Assigns a rank to each of the top 3 countries based on their event count.
  SELECT
    fe.event_name,
    fe.country,
    COUNT(*) AS event_count
  FROM
    filtered_events fe
  WHERE
    fe.country IN (SELECT country FROM top_countries)
  GROUP BY
    fe.event_name, fe.country
),

country_names AS ( -- Assigns a rank to each of the top 3 countries based on their event count.
  SELECT
    ROW_NUMBER() OVER (ORDER BY event_count DESC) AS rank,
    country
  FROM
    top_countries
)
SELECT
  ROW_NUMBER() OVER (ORDER BY 
    CASE event_totals.event_name
      WHEN 'page_view' THEN 1
      WHEN 'user_engagement' THEN 2
      WHEN 'view_item' THEN 3
      WHEN 'add_to_cart' THEN 4
      WHEN 'begin_checkout' THEN 5
      WHEN 'purchase' THEN 6
    END) AS event_order,
  event_totals.event_name,
  MAX(CASE WHEN country_names.rank = 1 THEN event_totals.event_count END) AS `1st Country events`,
  MAX(CASE WHEN country_names.rank = 2 THEN event_totals.event_count END) AS `2nd Country events`,
  MAX(CASE WHEN country_names.rank = 3 THEN event_totals.event_count END) AS `3rd Country events`
FROM
  event_totals
JOIN
  country_names ON event_totals.country = country_names.country
GROUP BY
  event_totals.event_name
ORDER BY
  event_order;