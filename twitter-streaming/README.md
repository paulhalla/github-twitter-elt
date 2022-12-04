# SQL Console
https://qega1y8l6b.ap-southeast-1.aws.clickhouse.cloud:8443/play?user=default


# ClickHouse 

```sql 
create table tweets (
    verified Bool,
    profile_image_url String,
    id String,
    created_at datetime,
    username String,
    author_id String,
    edit_history_tweet_ids Array(String),
    location String,
    name String,
    text String
) engine = MergeTree order by (id, created_at)
```

insert into default.tweets [()] values ()