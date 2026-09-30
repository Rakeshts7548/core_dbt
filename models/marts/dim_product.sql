{#on_schema_change='sync_all_columns'#}

{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['PRODUCT_ID'],
        tags=['mart','products']
    )
}}


SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    SUB_CATEGORY,
    BRAND,
    CREATED_TS,
    UPDATED_TS
FROM {{ ref('wi_product') }}