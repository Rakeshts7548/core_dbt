{{
    config
    (
        materialized='incremental',
        unique_key='PROMOTION_ID',
        pre_hook=["delete from {{this}};"],
        tags=['staging','promotions']
    )
}}
select 
PROMOTION_ID, PROMOTION_NAME, DISCOUNT_PERCENT, START_DATE, END_DATE, current_timestamp() as CREATED_TS,current_timestamp() as UPDATED_TS
 from {{ source('sales_raw','PROMOTION_RAW') }}
