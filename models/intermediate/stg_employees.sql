
with source as (
    select * from {{ source('src2','stg_employees')}}
),

change as (
select
    mkmotors_dev.staging.SEQCUST.NEXTVAL,
    employee_id,
    employee_first_name,
    employee_last_name,
    employee_gender,
    employee_fixedline,
    employee_age,
    position_type,
    dealership_id,
    region,
    employee_address,
    employee_city,
    employee_state,
    employee_zip_code,
    employee_mobile,
    employee_email,
    
    -- Single call to the combined macro
    {{ employee_transformations(
        'employee_first_name',
        'employee_last_name',
        'employee_gender',
        'employee_fixedline',
        'employee_age'
    ) }}

    
from source
)
select * from change