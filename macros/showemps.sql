{% macro showemps() %}
   {% do run_query('select employee_first_name from mkmotors.stg_employees') %}
{% endmacro %}


{% macro crt_stage() %}
   {% do run_query('create or replace stage int_stage') %}
{% endmacro %}

{% macro load_stage() %}
   {% do run_query('copy into @int_stage from stg_nations partition by (region_id) header=true  file_format =(compression=none)') %}
{% endmacro %}


{% macro unload_table_to_s3(model_to_unload, unload_file_name) %}
    
    {% set external_stage = "mkmotors_dev.staging.s3customers" %}
    
    {% set unload_sql %}
        -- Unload the data from a dbt model (your "out folder")
        COPY INTO @{{ external_stage }}/{{ unload_file_name }}
        FROM (SELECT * FROM {{ ref(model_to_unload) }})
        OVERWRITE = TRUE
        SINGLE = TRUE -- Saves as a single file (optional)
        FILE_FORMAT = (
            TYPE = CSV, 
            FIELD_DELIMITER = ',', 
            HEADER = TRUE
        );
    {% endset %}

    {% do run_query(unload_sql) %}
    
    {{ log("Successfully unloaded data from model '" ~ model_to_unload ~ "' to S3 via External Stage.", info=True) }}

{% endmacro %}



{% macro unload_stage() %}
   {% do run_query('copy into @mkmotors_dev.staging.s3customers/customers.csv from stg_customers header=true ;') %}
{% endmacro %}