{{
    config
    (
        materialized='incremental',
        pre_hook = ["truncate table  {{this}} ;"],
        tags=['intrim','products']
    )
}}

SELECT
       PRODUCT_ID,
    TRIM(PRODUCT_NAME) AS PRODUCT_NAME,
    UPPER(TRIM(CATEGORY)) AS CATEGORY,
    UPPER(TRIM(SUB_CATEGORY)) AS SUB_CATEGORY,
    UPPER(TRIM(BRAND)) AS BRAND,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('stg_product') }}