{{
    config
    (
        materialized='incremental',
        pre_hook = ["truncate table  {{this}} ;"],
        tags=['intrim','customers']
    )
}}

SELECT
    CUSTOMER_ID,
    TRIM(CUSTOMER_NAME) AS CUSTOMER_NAME,
    LOWER(EMAIL) AS EMAIL,
    PHONE,
    GENDER,
    CITY,
    STATE,
    COUNTRY,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('stg_customer') }}