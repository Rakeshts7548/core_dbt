{{
    config
    (
        materialized='incremental',
        unique_key='PROMOTION_ID',
        incremental_strategy='merge'
    )
}}
select * from {{ source('sales_raw','PROMOTION_RAW') }}
{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}
