
SELECT
--from raw orders
    {{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders
    , o.orderid
    , o.orderdate
    , o.shipdate
    , o.shipmode 
--    , d.delivery_team   
    , o.ordersellingprice - o.ordercostprice AS orderprofit
    , o.ordersellingprice
    , o.ordercostprice
    , {{ markup('ordersellingprice', 'ordercostprice') }} as markup
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
--LEFT JOIN {{ ref('delivery_team') }} AS d ON o.shipmode = d.shipmode
--{{ limit_data_in_dev('orderdate') }}
