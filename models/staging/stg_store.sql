{{
    config
    (
        materialized='incremental',
        unique_key='STORE_ID',
        pre_hook=["delete from {{this}};"],
        tags=['staging','stores']
    
    )
}}
select STORE_ID, STORE_NAME, CITY, STATE, COUNTRY, REGION,  current_timestamp() as CREATED_TS,current_timestamp() as UPDATED_TS
 from {{ source('sales_raw','STORE_RAW') }}
{#{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}
#}