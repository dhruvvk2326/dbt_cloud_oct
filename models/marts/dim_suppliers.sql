
{{config(materialized='incremental')}}



with suppliers as (
    select
        -- Supplier columns
        supplier_id,
  
        supplier_name,
        account_balance,
         phone_number,
        supplier_address,

        -- Nation columns
        nation_name,


        -- Region columns
        region_name,
        supplier_updated_time as updated_time
        from {{ref('int_suppliers')}}
        {% if is_incremental() %}
            where
                updated_time <  (
                    select coalesce(max(updated_time), '1900-01-01'::timestamp)
                    from {{ this }}
                )
        {% endif %}

    
)

select *,{{dbt_meta()}}
from suppliers