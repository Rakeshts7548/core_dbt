{{ config(
    materialized='table'
) }}

SELECT DISTINCT
    CUSTOMER_ID AS CUSTOMER_KEY,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    PHONE,
    GENDER,
    CITY,
    STATE,
    COUNTRY
FROM {{ ref('stg_customer') }}