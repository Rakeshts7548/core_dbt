{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['ORDER_ID','ORDER_LINE_ID'],
        on_schema_change='sync_all_columns',
        tags=['mart','sales']
    )
}}

SELECT
    ORDER_ID,
    ORDER_LINE_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
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
FROM {{ ref('wi_sales_order') }}