with source_data as (
    select
        username,
        name as user_full_name,
        id as user_id,
        public_metrics['followers_count'] as number_of_followers,
        public_metrics['following_count'] as number_of_following,
        public_metrics['tweet_count'] as number_of_tweets,
        public_metrics['listed_count'] as number_of_twitter_lists,
        pinned_tweet_id,
        description as user_description,
        created_at,
        verified
    from {{ source('public', 'raw_twitter_users') }}
)

select *
from source_data
