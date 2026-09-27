{{
    config
    (
        materialized='incremental',
        unique_key='STORE_ID',
        incremental_strategy='merge'
    )
}}
select * from {{ source('sales_raw','STORE_RAW') }}
{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}
