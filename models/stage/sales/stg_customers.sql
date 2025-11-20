{#{{ config(materialized="view",tags='sample',
        pre_hook="use warehouse test_wh",
        post_hook="select * from analytics.dbt_vel.stg_regions"
) }}#}

with
    customer as (
        select
            c_custkey as customer_id,
            c_nationkey as nation_id,
            c_name as name,
            c_address as address,
            c_phone as phone,
            c_acctbal as account_balance,
            c_mktsegment as market_segment,
            c_comment as comment

        from {{ source("src", "customers") }} 
    )

select *
from customer 
