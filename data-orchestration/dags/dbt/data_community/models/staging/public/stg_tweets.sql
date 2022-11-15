with source as (
    select * 
    from {{ source('public', 'serving_tweets') }}
)

select * from source