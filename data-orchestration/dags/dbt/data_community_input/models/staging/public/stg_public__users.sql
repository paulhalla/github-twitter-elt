{{
  config(
    materialized = "table",
    schema = 'public'
  )
}}

with loaded_at as (
  select * 
  from {{ ref('base_public__raw_users_loaded_at') }}
),

users as (
  select * 
  from {{ ref('base_public__raw_users') }}
  qualify row_number() over (partition by username order by user_id) = 1
),

transformed as (
  select 
    users.username,
    user_full_name,
    user_id,
    number_of_followers,
    number_of_following,
    number_of_tweets,
    number_of_twitter_lists,
    pinned_tweet_id,
    user_description,
    created_at,
    verified,
    coalesce(loaded_at.last_load_time, current_timestamp())::timestamp as last_load_time
  from users 
  left join loaded_at 
    on users.username = loaded_at.username
)

select * from transformed
