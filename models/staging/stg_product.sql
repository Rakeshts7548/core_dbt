{{
    config
    (
        materialized='incremental',
        unique_key='PRODUCT_ID',
        incremental_strategy='merge'
    )
}}
select * from {{ source('sales_raw','PRODUCT_RAW') }}
{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}
