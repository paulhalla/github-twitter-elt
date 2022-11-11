with source_data as (
    select
        cast(data['id'] as varchar) as tweet_id,
        username,
        cast(data['text'] as varchar) as tweet,
        cast(data['created_at'] as varchar) as tweet_created_at
    from {{ source('public', 'raw_tweets_full') }}
)

select *
from source_data
