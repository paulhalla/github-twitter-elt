with source as (
    select
        id as user_id,
        public_metrics['followers_count'] as number_of_followers,
        public_metrics['following_count'] as number_of_following,
        public_metrics['tweet_count'] as number_of_tweets,
        public_metrics['listed_count'] as number_of_twitter_lists
    from {{ source('public', 'raw_twitter_users') }}
)

select *
from source
