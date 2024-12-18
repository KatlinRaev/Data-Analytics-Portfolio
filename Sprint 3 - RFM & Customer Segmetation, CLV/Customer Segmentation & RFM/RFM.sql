WITH 
rfm AS (
    SELECT
      CustomerID,
      DATE(InvoiceDate) AS invoice_date,
      Quantity,
      UnitPrice, 
      InvoiceNo
    FROM
      `tc-da-1.turing_data_analytics.rfm`
    WHERE
      DATE(InvoiceDate) BETWEEN DATE("2010-12-01") AND DATE("2011-12-01")
      AND Quantity > 0 
      AND UnitPrice > 0 
      AND CustomerID IS NOT NULL
),
rfm_values AS (
    SELECT
      CustomerID,
      MAX(invoice_date) AS last_purchase_date,
      DATE_DIFF(DATE("2011-12-01"), MAX(invoice_date), DAY) AS recency,
      COUNT(DISTINCT InvoiceNo) AS frequency,
      SUM(IFNULL(Quantity, 0) * IFNULL(UnitPrice, 0)) AS Monetary 
    FROM
      rfm
    GROUP BY
      CustomerID
),
quartiles AS (
    SELECT
      APPROX_QUANTILES(recency, 4) AS recency_quartiles,
      APPROX_QUANTILES(frequency, 4) AS frequency_quartiles,
      APPROX_QUANTILES(Monetary, 4) AS monetary_quartiles
    FROM
      rfm_values
),
rfm_scores AS (
    SELECT
      rv.CustomerID,
      rv.recency,
      rv.frequency,
      rv.Monetary,
  
      -- Recency score
      CASE
        WHEN rv.recency <= q.recency_quartiles[OFFSET(1)] THEN 4
        WHEN rv.recency <= q.recency_quartiles[OFFSET(2)] THEN 3
        WHEN rv.recency <= q.recency_quartiles[OFFSET(3)] THEN 2
        ELSE 1
      END AS recency_score,
  
      -- Frequency score
      CASE
        WHEN rv.frequency <= 1 THEN 1
        WHEN rv.frequency <= 2 THEN 2
        WHEN rv.frequency <= 4 THEN 3
        ELSE 4
      END AS frequency_score,

      -- Monetary score
      CASE
        WHEN rv.Monetary >= q.monetary_quartiles[OFFSET(3)] THEN 4
        WHEN rv.Monetary >= q.monetary_quartiles[OFFSET(2)] THEN 3
        WHEN rv.Monetary >= q.monetary_quartiles[OFFSET(1)] THEN 2
        ELSE 1
      END AS monetary_score,

      -- Calculate Common RFM score (concatenate R, F, and M scores as a string)
      CONCAT(
        CASE
          WHEN rv.recency <= q.recency_quartiles[OFFSET(1)] THEN '4'
          WHEN rv.recency <= q.recency_quartiles[OFFSET(2)] THEN '3'
          WHEN rv.recency <= q.recency_quartiles[OFFSET(3)] THEN '2'
          ELSE '1'
        END,
        CASE
          WHEN rv.frequency <= 1 THEN '1'
          WHEN rv.frequency <= 2 THEN '2'
          WHEN rv.frequency <= 4 THEN '3'
          ELSE '4'
        END,
        CASE
          WHEN rv.Monetary >= q.monetary_quartiles[OFFSET(3)] THEN '4'
          WHEN rv.Monetary >= q.monetary_quartiles[OFFSET(2)] THEN '3'
          WHEN rv.Monetary >= q.monetary_quartiles[OFFSET(1)] THEN '2'
          ELSE '1'
        END
      ) AS common_rfm_scores
    FROM
      rfm_values rv, quartiles q
),
segmentation AS (
    SELECT
      CustomerID,
      recency,
      frequency,
      Monetary,
      recency_score,
      frequency_score,
      monetary_score,
      common_rfm_scores,
      
      -- Customer Segmentation based on RFM score
      CASE
        WHEN common_rfm_scores = '444' THEN 'Best Customers'
        WHEN common_rfm_scores IN ('111', '112', '113', '114') THEN 'Lost Customers'
        WHEN common_rfm_scores IN ('141', '142', '143', '241', '242', '243', '341', '342', '343', '441', '442', '443, 144', '244', '344') THEN 'Loyal Customers'
        WHEN common_rfm_scores IN ('114', '123', '134', '214', '224', '234', '314', '324', '334', '414', '424', '434') THEN 'Big Spenders'
        ELSE 'Other'
      END AS customer_segment
    FROM
      rfm_scores
)
SELECT
  segmentation.CustomerID,
  segmentation.recency,
  segmentation.frequency,
  segmentation.Monetary,
  segmentation.recency_score,
  segmentation.frequency_score,
  segmentation.monetary_score,
  segmentation.common_rfm_scores,
  segmentation.customer_segment
FROM
  segmentation
ORDER BY
  segmentation.CustomerID;
