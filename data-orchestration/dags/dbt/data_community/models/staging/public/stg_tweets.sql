with source_data as (
    select 
        username,
        dt.value:created_at::varchar as tweet_created_at,
        dt.value:edit_history_tweet_ids[0]::varchar as edit_history_tweet_ids,
        dt.value:id::varchar as id,
        dt.value:text::varchar as text,
        dt.value:public_metrics:like_count as like_count,
        dt.value:public_metrics:quote_count as quote_count,
        dt.value:public_metrics:reply_count as reply_count,
        dt.value:public_metrics:retweet_count as retweet_count
    from {{ source('public', 'raw_tweets_full') }},
    lateral flatten(input => data) source_data
)

select *
from source_data
