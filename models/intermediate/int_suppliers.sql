
{{config(tags='sample',materialized='table')}}

with suppliers as (
    select
        supplier_id,
        nation_id,
        supplier_name,
        supplier_address,
        phone_number,
        comment             as supplier_comment,
        account_balance,
        updated_time        as supplier_updated_time
    from {{ ref('stg_suppliers') }}
),

nations as (
    select
        nation_id,
        nation_name,
        region_id,
        updated_at          as nation_updated_at
    from {{ ref('stg_nations') }}
),

regions as (
    select
        region_id,
        region_name,
        comment             as region_comment
    from {{ ref('stg_regions') }}
),

final as (
    select
        -- Supplier columns
        s.supplier_id,
  
        s.supplier_name,
        s.account_balance,
         s.phone_number,
        s.supplier_address,

        -- Nation columns
        n.nation_name,


        -- Region columns
        r.region_name,
        s.supplier_updated_time,
        {{dbt_meta()}}


    from suppliers s
    join nations n 
        on s.nation_id = n.nation_id
    join regions r
        on n.region_id = r.region_id
)

select * from final