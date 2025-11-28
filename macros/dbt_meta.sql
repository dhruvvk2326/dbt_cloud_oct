


{% macro dbt_meta() %}
  '{{invocation_id}}'::varchar as ivo_id,
  '{{run_started_at}}'::timestamp as run_id
{% endmacro %}