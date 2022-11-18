with source as (
    select * 
    from {{ source('public', 'ingest_twitter_users') }}
)

select * from source