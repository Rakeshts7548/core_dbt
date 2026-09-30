{{
    config
    (
        materialized='incremental',
        pre_hook = ["truncate table  {{this}} ;"],
        tags=['intrim','promotions']
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
FROM {{ ref('stg_promotion') }}