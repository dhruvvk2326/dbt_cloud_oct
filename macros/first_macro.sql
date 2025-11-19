{% macro jodo(col1, col2) %}
    
    {{col1}} || ' ' || {{col2}}
{% endmacro %}


{% macro full_name(first, last) %}
    {{ first }} || ' ' || {{ last }}
{% endmacro %}




{% macro formatted_phone(phone) %}
    '(' || substring({{ phone }},1,3) || ') ' ||
    substring({{ phone }},4,3) || '-' ||
    substring({{ phone }},7,4)
{% endmacro %}

{% macro age_group(age) %}
    case
        when {{ age }} < 30 then 'Youngest'
        when {{ age }} between 30 and 60 then 'Middle'
        else 'Senior'
    end
{% endmacro %}



{% macro employee_transformations(first, last, gender, phone, age) %}
    
    -- Full Name Logic (previously full_name macro)
    {{ first }} || ' ' || {{ last }} as employee_name,
    
    -- Gender Label Logic (previously gender_label macro)
    case upper({{ gender }})
        when 'F' then 'Female'
        when 'M' then 'Male'
        else 'Other'
    end as gender_label,
    
    -- Formatted Phone Logic (previously formatted_phone macro)
    '(' || substring({{ phone }},1,3) || ') ' ||
    substring({{ phone }},4,3) || '-' ||
    substring({{ phone }},7,4) as formatted_phone,
    
    -- Age Group Logic (previously age_group macro)
    case
        when {{ age }} < 30 then 'Youngest'
        when {{ age }} between 30 and 60 then 'Middle'
        else 'Senior'
    end as age_group
    
{% endmacro %}



