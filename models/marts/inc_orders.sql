{{config(materialized="incremental",
             unique_key="order_id")}}

with source as (
    select * from {{ ref('stg_orders') }}
),

changed as (
    select
        --ids
        order_id,
        customer_id,

        --descriptions
        comment,
clerk_name,

        --numbers
        total_price,

        --statuses
        status_code,
        priority_code,
        ship_priority,

        --dates
        order_date, -- Removed the trailing comma here
        updated_at
    from source
)

select * from changed