{{
    config
    (
        materialized='incremental',
        unique_key='ORDER_ID',
        incremental_strategy='merge'
    )
}}
select ORDER_ID, ORDER_LINE_ID, ORDER_DATE, CUSTOMER_ID, PRODUCT_ID, STORE_ID, PROMOTION_ID, QUANTITY, UNIT_PRICE, DISCOUNT_AMOUNT, TAX_AMOUNT, ORDER_STATUS,
current_timestamp() as CREATED_TS,current_timestamp() as UPDATED_TS
 from {{ source('sales_raw','SALES_ORDER_RAW') }}
{% if is_incremental() %}
where UPDATED_TS > (select max(UPDATED_TS) from {{ this }})
{% endif %}
