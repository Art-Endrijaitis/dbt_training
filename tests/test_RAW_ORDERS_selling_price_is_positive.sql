
WITH orders AS (
    SELECT *
    FROM {{ ref('RAW_ORDERS') }}
)

SELECT
    orderid, SUM(ordersellingprice) AS total_sp
FROM orders
GROUP BY orderid
HAVING total_sp < 0
