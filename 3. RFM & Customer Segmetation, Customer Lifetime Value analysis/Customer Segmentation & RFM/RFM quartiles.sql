WITH rfm_values AS (
    SELECT
      CustomerID,
      MAX(DATE(InvoiceDate)) AS last_purchase_date,
      DATE_DIFF(DATE("2011-12-01"), MAX(DATE(InvoiceDate)), DAY) AS recency,
      COUNT(DISTINCT InvoiceNo) AS frequency,
      SUM(Quantity * UnitPrice) AS monetary
    FROM
      `tc-da-1.turing_data_analytics.rfm`
    WHERE
      DATE(InvoiceDate) BETWEEN DATE("2010-12-01") AND DATE("2011-12-01")
      AND Quantity > 0
      AND UnitPrice > 0
      AND CustomerID IS NOT NULL
    GROUP BY
      CustomerID
)
SELECT
  APPROX_QUANTILES(monetary, 4)[OFFSET(1)] AS m25,
  APPROX_QUANTILES(monetary, 4)[OFFSET(2)] AS m50,
  APPROX_QUANTILES(monetary, 4)[OFFSET(3)] AS m75,
  APPROX_QUANTILES(frequency, 4)[OFFSET(1)] AS f25,
  APPROX_QUANTILES(frequency, 4)[OFFSET(2)] AS f50,
  APPROX_QUANTILES(frequency, 4)[OFFSET(3)] AS f75,
  APPROX_QUANTILES(recency, 4)[OFFSET(1)] AS r25,
  APPROX_QUANTILES(recency, 4)[OFFSET(2)] AS r50,
  APPROX_QUANTILES(recency, 4)[OFFSET(3)] AS r75
FROM
  rfm_values;
