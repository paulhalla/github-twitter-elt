with source_data as (
    select 
        username,
        dt.value:created_at::varchar as tweet_created_at,
        dt.value:edit_history_tweet_ids[0]::varchar as edit_history_tweet_ids,
        dt.value:id::varchar as id,
        dt.value:text::varchar as text,
        dt.value:public_metrics:like_count::integer as number_of_likes,
        dt.value:public_metrics:quote_count::integer as number_of_quotes,
        dt.value:public_metrics:reply_count::integer as number_of_replies,
        dt.value:public_metrics:retweet_count::integer as number_of_retweets
    from {{ source('public', 'raw_tweets_full') }},
    lateral flatten(input => data) dt  
)

select *
from source_data
