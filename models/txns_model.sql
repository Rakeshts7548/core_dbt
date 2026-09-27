{{ config(materialized='table') }}

select *
from {{ source('retails', 'TRANSACTION_RAW') }}
where basket_id = '29330027026'