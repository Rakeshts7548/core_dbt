{{
    config(
        materialized='incremental',
        unique_key=['ORDER_ID','ORDER_LINE_ID'],
        pre_hook = ["truncate table  {{this}} ;"],
        tags=['intrim','sales_customer_product']
    )
}}

SELECT
    S.ORDER_ID,
    S.ORDER_LINE_ID,
    S.ORDER_DATE,
    C.CUSTOMER_ID,
    C.CUSTOMER_NAME,
    P.PRODUCT_ID,
    P.PRODUCT_NAME,
    S.QUANTITY,
    S.UNIT_PRICE,
    S.GROSS_SALES_AMOUNT,
    S.DISCOUNT_AMOUNT,
    S.NET_SALES_AMOUNT,
    S.TAX_AMOUNT,
    S.TOTAL_SALES_AMOUNT,
    S.ORDER_STATUS,
    S.CREATED_TS,
    S.UPDATED_TS
FROM {{ ref('wi_sales_order') }} S
LEFT JOIN {{ ref('dim_customer') }} C
    ON S.CUSTOMER_ID = C.CUSTOMER_ID
LEFT JOIN {{ ref('dim_product') }} P
    ON S.PRODUCT_ID = P.PRODUCT_ID

{% if is_incremental() %}

WHERE NOT EXISTS (
    SELECT 1
    FROM {{ this }} W
    WHERE W.ORDER_ID = S.ORDER_ID
      AND W.ORDER_LINE_ID = S.ORDER_LINE_ID
)

{% endif %}