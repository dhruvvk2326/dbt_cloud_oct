{# parameterize the following variables #}
{% set size = 15 %}
{% set type = 'BRASS' %}
{% set region = 'EUROPE' %}

{# can use already declared variables in a .yml file #}
{# % set size = var('size') % #}
{# % set type = var('type') % #}
{# % set region = var('region') % #}

select
    account_balance,
    supplier_name,
    n_name as Nation,
    p_partkey as Part_Key,
    p_mfgr as Manufacturer,
    supplier_address,
    phone_number
from
    {{ source('src', 'parts') }}, {{ ref('stg_suppliers') }},
    {{ source('src', 'partsupps') }}, {{ source('src', 'nations') }}, 
    {{ source('src', 'regions') }}

where
    p_partkey = ps_partkey
    and supplier_id = ps_suppkey
    and p_size = {{ size }}
    and p_type like '%{{ type }}%'
    and nation_id = n_nationkey
    and n_regionkey = r_regionkey
    and r_name = '{{ region }}'
    and ps_supplycost = (
        select 
            min(ps_supplycost)
        from
        {{ source('src', 'partsupps') }}, {{ ref('stg_suppliers') }},
        {{ source('src', 'nations') }}, {{ source('src', 'regions') }}
        where
            p_partkey = ps_partkey
            and supplier_id = ps_suppkey
            and nation_id = n_nationkey
            and n_regionkey = r_regionkey
            and r_name = '{{ region }}'
    )
order by
        account_balance desc,
    n_name,
    supplier_name,
    p_partkey
    
    