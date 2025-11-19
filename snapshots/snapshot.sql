{% snapshot scd_orders %}
{{
    config(
        target_database='ANALYTICS',
        target_schema='SCDS',
        alias= 'v3',
        unique_key='O_ORDERKEY',
        strategy='check',
        check_cols=['O_ORDERPRIORITY','O_ORDERDATE','O_COMMENT'],
        hard_deletes= 'new_record'
    )
}}
    select *
    from {{ source('src', 'orders') }}
{% endsnapshot %}