{{ config(
    materialized='table'
) }}

SELECT
    s.ORDER_ID,
    s.ORDER_LINE_ID,
    s.ORDER_DATE,
    s.CUSTOMER_ID,
    c.CUSTOMER_NAME,
    c.GENDER,
    c.CITY,
    c.STATE,
    s.PRODUCT_ID,
    p.PRODUCT_NAME,
    p.CATEGORY,
    p.SUB_CATEGORY,
    p.BRAND,
    s.STORE_ID,
    st.STORE_NAME,
    st.REGION,
    s.PROMOTION_ID,
    pr.PROMOTION_NAME,
    pr.DISCOUNT_PERCENT,
    s.QUANTITY,
    s.UNIT_PRICE,
    (s.QUANTITY * s.UNIT_PRICE) AS GROSS_AMOUNT,
    s.DISCOUNT_AMOUNT,
    s.TAX_AMOUNT,
    (
        (s.QUANTITY * s.UNIT_PRICE)
        - s.DISCOUNT_AMOUNT
        + s.TAX_AMOUNT
    ) AS NET_SALES_AMOUNT,
    s.ORDER_STATUS,
    s.CREATED_TS,
    s.UPDATED_TS
FROM {{ ref('stg_sales_order') }} s
LEFT JOIN {{ ref('stg_customer') }} c
    ON s.CUSTOMER_ID = c.CUSTOMER_ID
LEFT JOIN {{ ref('stg_product') }} p
    ON s.PRODUCT_ID = p.PRODUCT_ID
LEFT JOIN {{ ref('stg_store') }} st
    ON s.STORE_ID = st.STORE_ID
LEFT JOIN {{ ref('stg_promotion') }} pr
    ON s.PROMOTION_ID = pr.PROMOTION_ID
