with source_data as (
    select
        username,
        data,
        metadata
    from {{ source('public', 'raw_tweets_full')}}
)

select *
from source_data