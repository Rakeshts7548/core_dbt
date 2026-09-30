{#on_schema_change='sync_all_columns'#}

{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['CUSTOMER_ID'],
        tags=['mart','customers']
    )
}}

SELECT 
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    PHONE,
    GENDER,
    CITY,
    STATE,
    COUNTRY,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('wi_customer') }}