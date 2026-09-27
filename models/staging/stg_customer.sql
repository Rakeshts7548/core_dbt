{{
    config
    (
        materialized='incremental',
        unique_key='CUSTOMER_ID',
        incremental_strategy='merge'
    )
}}
select * from {{ source('sales_raw','CUSTOMER_RAW') }}
{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}
