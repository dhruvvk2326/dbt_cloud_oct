{% macro add_col(table, colname, var) %}
    {% do run_query('alter table ' ~ table ~ ' add column if not exists ' ~ colname ~ ' ' ~ var ~ ';') %}
{% endmacro %}


