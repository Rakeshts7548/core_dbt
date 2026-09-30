{{
    config
    (
        materialized='incremental',
        unique_key='PRODUCT_ID',
        pre_hook=["delete from {{this}};"],
        tags=['staging','products']

    )
}}
select PRODUCT_ID, PRODUCT_NAME, CATEGORY, SUB_CATEGORY, BRAND, UNIT_COST, UNIT_PRICE,  current_timestamp() as CREATED_TS,current_timestamp() as UPDATED_TS
 from {{ source('sales_raw','PRODUCT_RAW') }}
{#{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}#}

