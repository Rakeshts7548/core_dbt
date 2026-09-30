{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['STORE_ID'],
        tags=['mart','stores']
    )
}}

SELECT 
    STORE_ID,
    STORE_NAME,
    CITY,
    STATE,
    COUNTRY,
    REGION,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('wi_store') }}