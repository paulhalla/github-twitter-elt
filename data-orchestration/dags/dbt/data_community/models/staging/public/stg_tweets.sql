
with load_times as (
    select * 
    from {{ ref('base_public_raw_tweets_snapshot') }}
),

joined as (
    select 
        raw_tweets.username,
        tweet_created_at,
        edit_history_tweet_ids,
        id,
        tweet,
        number_of_likes,
        number_of_quotes,
        number_of_replies,
        number_of_retweets,
        coalesce(load_times.last_load_time, current_timestamp())::timestamp as last_load_time
    from {{ ref('base_public_raw_tweets') }} raw_tweets
    left join load_times 
        on raw_tweets.username = load_times.username
),

remove_dupes as (
    select *,
        row_number() over(partition by id order by tweet_created_at) row_num
    from joined
)

select *
from remove_dupes
where row_num = 1