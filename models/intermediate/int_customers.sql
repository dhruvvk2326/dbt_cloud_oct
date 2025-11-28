WITH customer AS (
    SELECT
        *
    FROM {{ ref('stg_customers') }}
),
nation AS (
    SELECT
       *
    FROM {{ ref('stg_nations') }}
),
region AS (
    SELECT
      *
    FROM {{ ref('stg_regions') }}
),
combined AS (
    SELECT
        sc.customer_id,
        sc.name,
        sc.address,
        sc.phone,
        sc.account_balance,
        sc.market_segment,
        sc.comment as customer_comment,
        n.nation_name,
        n.nation_id,
        n.updated_at,
        r.region_id,
        r.region_name,
        r.comment as region_comment
    FROM customer sc
    JOIN nation n ON sc.nation_id = n.nation_id
    JOIN region r ON n.region_id = r.region_id
)
SELECT * FROM combined