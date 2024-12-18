WITH reference_date AS (
    SELECT DATE '2021-02-07' AS ref_date
),
subs_weeks AS (
    SELECT
        DATE_TRUNC(subscription_start, WEEK(MONDAY)) AS weeks, 
        user_pseudo_id,
        subscription_start,  
        subscription_end     
    FROM `tc-da-1.turing_data_analytics.subscriptions`
)

SELECT
    weeks,
    COUNT(user_pseudo_id) AS week_0,
    SUM(CASE 
            WHEN subscription_start < DATE_ADD(weeks, INTERVAL 1 WEEK) 
                AND (subscription_end >= DATE_ADD(weeks, INTERVAL 1 WEEK) OR subscription_end IS NULL)
                AND DATE_ADD(weeks, INTERVAL 1 WEEK) <= (SELECT ref_date FROM reference_date)
            THEN 1 ELSE 0 
        END) AS week_1,
    SUM(CASE 
            WHEN subscription_start < DATE_ADD(weeks, INTERVAL 2 WEEK) 
                AND (subscription_end >= DATE_ADD(weeks, INTERVAL 2 WEEK) OR subscription_end IS NULL)
                AND DATE_ADD(weeks, INTERVAL 2 WEEK) <= (SELECT ref_date FROM reference_date)
            THEN 1 ELSE 0 
        END) AS week_2,
    SUM(CASE 
            WHEN subscription_start < DATE_ADD(weeks, INTERVAL 3 WEEK) 
                AND (subscription_end >= DATE_ADD(weeks, INTERVAL 3 WEEK) OR subscription_end IS NULL)
                AND DATE_ADD(weeks, INTERVAL 3 WEEK) <= (SELECT ref_date FROM reference_date)
            THEN 1 ELSE 0 
        END) AS week_3,
    SUM(CASE 
            WHEN subscription_start < DATE_ADD(weeks, INTERVAL 4 WEEK) 
                AND (subscription_end >= DATE_ADD(weeks, INTERVAL 4 WEEK) OR subscription_end IS NULL)
                AND DATE_ADD(weeks, INTERVAL 4 WEEK) <= (SELECT ref_date FROM reference_date)
            THEN 1 ELSE 0 
        END) AS week_4,
    SUM(CASE 
            WHEN subscription_start < DATE_ADD(weeks, INTERVAL 5 WEEK) 
                AND (subscription_end >= DATE_ADD(weeks, INTERVAL 5 WEEK) OR subscription_end IS NULL)
                AND DATE_ADD(weeks, INTERVAL 5 WEEK) <= (SELECT ref_date FROM reference_date)
            THEN 1 ELSE 0 
        END) AS week_5,
    SUM(CASE 
            WHEN subscription_start < DATE_ADD(weeks, INTERVAL 6 WEEK) 
                AND (subscription_end >= DATE_ADD(weeks, INTERVAL 6 WEEK) OR subscription_end IS NULL)
                AND DATE_ADD(weeks, INTERVAL 6 WEEK) <= (SELECT ref_date FROM reference_date)
            THEN 1 ELSE 0 
        END) AS week_6
        
FROM subs_weeks 
GROUP BY weeks  
ORDER BY weeks;
