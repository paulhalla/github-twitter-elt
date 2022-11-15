with source as (
    select * 
    from {{ source('public', 'stg_public__users') }}
)

select * from source