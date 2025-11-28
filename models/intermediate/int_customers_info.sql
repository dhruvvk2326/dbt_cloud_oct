
with combined as(
SELECT 
    c.customer_id,
    c.NAME,
    c.market_segment AS Customer_Market_Segment,
    
    MIN(o.order_date) AS First_Ordered_At,
    
    MAX(o.order_date) AS Last_Ordered_At,
    
    COUNT(DISTINCT o.order_id) AS Lifetime_Orders,
    

    SUM(l.extended_price * l.tax) AS Lifetime_Tax,

    SUM(l.extended_price * (1 - l.discount) * (1 + l.tax)) AS Lifetime_Total,
    

    CASE 
        WHEN SUM(l.extended_price * (1 - l.discount) * (1 + l.tax)) > 500000 THEN 'VIP'
        WHEN SUM(l.extended_price * (1 - l.discount) * (1 + l.tax)) BETWEEN 100000 AND 500000 THEN 'Mid-Tier'
        ELSE 'Low Spender'
    END AS Customer_Spending_Type,


    CASE 
        WHEN COUNT(DISTINCT o.order_id) > 1 THEN 'Repeated Customer'
        ELSE 'New Customer'
    END AS Customer_Status

FROM 
    {{ref('stg_customers')}} c
JOIN 
    {{ref('stg_orders')}} o 
    ON c.customer_id = o.customer_id
JOIN 
    {{ref('stg_line_items')}} l 
    ON o.order_id = l.order_id
GROUP BY 
    c.customer_id, 
    c.name, 
    c.market_segment
ORDER BY 
    Lifetime_Total DESC
)

select * from combined