{{ config(
    materialized='incremental',
    unique_key='ORDER_ID',
    incremental_strategy='merge'
) }}

SELECT
    e.ORDER_ID,
    e.ORDER_LINE_ID,
    TO_NUMBER(
        TO_CHAR(e.ORDER_DATE,'YYYYMMDD')
    ) AS DATE_KEY,
    e.CUSTOMER_ID AS CUSTOMER_KEY,
    e.PRODUCT_ID AS PRODUCT_KEY,
    e.STORE_ID AS STORE_KEY,
    e.QUANTITY,
    e.UNIT_PRICE,
    e.GROSS_AMOUNT,
    e.DISCOUNT_AMOUNT,
    e.TAX_AMOUNT,
    e.NET_SALES_AMOUNT,
    e.ORDER_STATUS,
    CURRENT_TIMESTAMP AS LOAD_TS
FROM {{ ref('int_sales_enriched') }} e
{% if is_incremental() %}
WHERE e.UPDATED_TS >
(
    SELECT COALESCE(MAX(LOAD_TS),'1900-01-01')
    FROM {{ this }}
)
{% endif %}