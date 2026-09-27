{{ config(
    materialized='table'
) }}

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    SUB_CATEGORY,
    TOTAL_ORDERS,
    TOTAL_QUANTITY,
    TOTAL_GROSS_SALES,
    TOTAL_DISCOUNT,
    TOTAL_NET_SALES,
    ROUND(
        TOTAL_NET_SALES /
        NULLIF(TOTAL_QUANTITY,0),
        2
    ) AS AVG_SELLING_PRICE
FROM {{ ref('int_product_sales_summary') }}