{{ config(
    materialized='table'
) }}

SELECT DISTINCT
    STORE_ID AS STORE_KEY,
    STORE_ID,
    STORE_NAME,
    CITY,
    STATE,
    COUNTRY,
    REGION
FROM {{ ref('stg_store') }}