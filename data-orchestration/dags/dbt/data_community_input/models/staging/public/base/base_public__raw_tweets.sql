with source_data as (
    
    select * 
    from {{ source('public', 'raw_tweets_full') }}

)

select 
    lower(username) as username,
    dt.value:created_at::varchar as tweet_created_at,
    dt.value:edit_history_tweet_ids[0]::varchar as edit_history_tweet_ids,
    dt.value:id::varchar as id,
    dt.value:text::varchar as tweet,
    dt.value:public_metrics:like_count::integer as number_of_likes,
    dt.value:public_metrics:quote_count::integer as number_of_quotes,
    dt.value:public_metrics:reply_count::integer as number_of_replies,
    dt.value:public_metrics:retweet_count::integer as number_of_retweets
from source_data,
    lateral flatten(input => data) dt 