with source as (
    select * 
    from {{ source('public', 'stg_public__tweets') }}
)

select * from source