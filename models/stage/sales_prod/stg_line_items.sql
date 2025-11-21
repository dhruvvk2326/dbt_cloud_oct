with source as (
    select * from {{ source('src','lineitems')}}
),

line as(
select 
        {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber'])}} as order_item_id,
       l_orderkey as order_id,
       l_partkey as part_id,
       l_suppkey as supplier_id,

       l_linenumber as line_number,
       l_comment as comment,
       l_shipmode as ship_mode,
       l_shipinstruct as ship_instruction,

       l_quantity as quantity,
       l_extendedprice as extended_price,
       l_discount as discount,
       l_tax as tax,

       l_linestatus as line_status,
       l_returnflag as return_flag,
    
       l_shipdate as ship_date,
       l_commitdate as commit_date,
       l_receiptdate as receipt_date
from source
       
)
select * from line