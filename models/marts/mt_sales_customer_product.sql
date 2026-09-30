{{
    config(
        materialized='incremental',
        unique_key=['ORDER_ID','ORDER_LINE_ID'],
        incremental_strategy='merge',
        tags=['mt_layer','sales_customer_product']
    )
}}

SELECT
    ORDER_ID,
    ORDER_LINE_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    PRODUCT_ID,
    PRODUCT_NAME,
    QUANTITY,
    UNIT_PRICE,
    GROSS_SALES_AMOUNT,
    DISCOUNT_AMOUNT,
    NET_SALES_AMOUNT,
    TAX_AMOUNT,
    TOTAL_SALES_AMOUNT,
    ORDER_STATUS,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('wi_sales_customer_product') }}