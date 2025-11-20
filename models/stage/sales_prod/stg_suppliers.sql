{{config(materialized='ephemeral')}}


WITH supply AS (
    SELECT
        -- ids
        src.s_suppkey AS supplier_id,
        src.s_nationkey AS nation_id,
        -- descriptions
        suppliers.sname AS supplier_name,
        src.s_address AS supplier_address,
        src.s_phone AS phone_number,
        src.s_comment AS comment,
        -- amounts
        src.s_acctbal AS account_balance,
        src.updated_time
    FROM {{ source("src", "suppliers") }} AS src
    JOIN {{ ref('suppliers') }} AS suppliers
        ON src.s_suppkey = suppliers.skey
)
SELECT *
FROM supply
