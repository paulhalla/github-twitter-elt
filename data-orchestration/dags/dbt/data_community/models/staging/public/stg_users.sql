with source_data as (
    select
        username,
        name as user_full_name,
        id,
        public_metrics,
        pinned_tweet_id,
        description as user_description,
        created_at,
        verified
    from {{ source('public', 'raw_twitter_users') }}
)

select *
from source_data
