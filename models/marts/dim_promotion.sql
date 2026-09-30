{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['PROMOTION_ID'],
        tags=['mart','promotions']
    )
}}

SELECT
    PROMOTION_ID,
    PROMOTION_NAME, 
    DISCOUNT_PERCENT, 
    START_DATE, 
    END_DATE,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('wi_promotion') }}