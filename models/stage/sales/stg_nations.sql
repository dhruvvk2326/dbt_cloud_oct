{{config(
    query_tag='TEST1',
    alias=this.name+var('v_id'),
    access= 'public'
    
)}}

with nation as (
select  n_regionkey as region_id,
        n_nationkey as nation_id,
        n_name as nation_name,
        updated_at 

from {{ source('src', 'nations') }}
)

select * from nation