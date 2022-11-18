with source as (
    select * 
    from {{ source('public', 'input_twitter_users') }}
)

select * from source