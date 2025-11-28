{{ config(materialized="incremental",
             unique_key="customer_id")
 }}

with
    customer as (
        select
             customer_id,
            nation_id,
            name,
            address,
               phone,
         account_balance,
             market_segment,
         comment,
         updated_at

        from {{ ref('stg_customers') }} 
        {% if is_incremental() %}
            where
                updated_at > (
                    select coalesce(max(updated_at), '1900-01-01'::timestamp)
                    from {{ this }}
                )
        {% endif %}
    )

select *
from customer 
