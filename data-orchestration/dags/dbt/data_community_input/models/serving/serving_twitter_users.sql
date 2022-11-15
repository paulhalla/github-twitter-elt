{{
  config(
    materialized = "table",
    schema='public'
  )
}}

with source as (
    select * 
    from {{ ref('stg_public__users') }}
)
select * 
from source 