with orders as(
    select * from {{ ref('stg_orders') }}
)

select order_id from orders where total_price <= 900