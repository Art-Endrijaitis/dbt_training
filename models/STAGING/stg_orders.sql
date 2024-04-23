
SELECT 
--from raw orders
    o.orderid
    , o.orderdate
    , o.shipdate
    , o.shipmode    
    , o.ordersellingprice - o.ordercostprice AS orderprofit
    , o.ordersellingprice
    , o.ordercostprice
--from raw customer
    , c.customerid
    , c.customername
    , c.segment
    , c.country
--from raw product
    , p.category
    , p.productname
    , p.subcategory
    , p.productid
FROM {{ ref('RAW_ORDERS') }} AS o
LEFT JOIN {{ ref('RAW_CUSTOMER') }} AS c ON o.customerid = c.customerid
LEFT JOIN {{ ref('RAW_PRODUCT') }} AS p ON o.productid = p.productid
