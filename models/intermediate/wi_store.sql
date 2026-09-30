{{
    config
    (
        materialized='incremental',
        pre_hook = ["truncate table  {{this}} ;"],
        tags=['intrim','stores']
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
FROM {{ ref('stg_store') }}