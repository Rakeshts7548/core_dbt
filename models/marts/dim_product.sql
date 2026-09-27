{{ config(
    materialized='table'
) }}

SELECT DISTINCT
    PRODUCT_ID AS PRODUCT_KEY,
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    SUB_CATEGORY,
    BRAND
FROM {{ ref('stg_product') }}