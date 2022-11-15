with source as (
    select * 
    from {{ source('public', 'serving_twitter_users') }}
)

select * from source