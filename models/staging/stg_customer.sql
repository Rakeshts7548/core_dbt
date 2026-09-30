{# unique_key='CUSTOMER_ID' #}
{# pre_hook=["delete from {{this}};"] #}

{{
    config(
        materialized='incremental',
        pre_hook=["truncate table {{this}};"],
        tags=['staging','customer']
    )
}}

select  CUSTOMER_ID, CUSTOMER_NAME, EMAIL, PHONE, GENDER, CITY, STATE, COUNTRY, current_timestamp() as CREATED_TS,current_timestamp() as UPDATED_TS
from {{ source('sales_raw','CUSTOMER_RAW') }}