{{
    config
    (
        materialized='incremental',
        unique_key='ORDER_ID',
        pre_hook = ["delete from {{this}} ;"],
        tags=['staging','salesorders']
    )
}}
select ORDER_ID, ORDER_LINE_ID, ORDER_DATE, CUSTOMER_ID, PRODUCT_ID, STORE_ID, PROMOTION_ID, QUANTITY, UNIT_PRICE, DISCOUNT_AMOUNT, TAX_AMOUNT, ORDER_STATUS,
current_timestamp() as CREATED_TS,current_timestamp() as UPDATED_TS
 from {{ source('sales_raw','SALES_ORDER_RAW') }}
