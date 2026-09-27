{{ config(
    materialized='table'
) }}

SELECT
    STORE_ID,
    STORE_NAME,
    REGION,
    TOTAL_ORDERS,
    TOTAL_QUANTITY,
    TOTAL_GROSS_SALES,
    TOTAL_DISCOUNT,
    TOTAL_NET_SALES,
    ROUND(
        TOTAL_NET_SALES /
        NULLIF(TOTAL_ORDERS,0),
        2
    ) AS AVG_ORDER_VALUE
FROM {{ ref('int_store_sales_summary') }}