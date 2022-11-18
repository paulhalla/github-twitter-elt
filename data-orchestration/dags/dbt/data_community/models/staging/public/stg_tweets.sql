with source as (
    select * 
    from {{ source('public', 'input_tweets') }}
)

select * from source