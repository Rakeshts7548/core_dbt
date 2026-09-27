{{ config(
    materialized='table'
) }}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    TOTAL_ORDERS,
    TOTAL_QUANTITY,
    TOTAL_GROSS_SALES,
    TOTAL_DISCOUNT,
    TOTAL_NET_SALES,
    FIRST_ORDER_DATE,
    LAST_ORDER_DATE,
    ROUND(
        TOTAL_NET_SALES / NULLIF(TOTAL_ORDERS,0),
        2
    ) AS AVG_ORDER_VALUE
FROM {{ ref('int_customer_order_summary') }}