# Incremental Extraction of tweets from Twitter 

## Todos
1. Extract user and tweet data.
2. Set up an RDS to store the tweets.

	- The users will be stored in a `user` table
	- The tweets of the users will be stored in a `tweet` table 
	- The metrics of a tweet will be stored in a `tweet_metrics` table.
	- Tweet watermarks are stored in the `tweet_watermarks` table.

3. Create raw and serving schemas

```sql

-- create schema 
drop schema if exists raw cascade;
create schema raw;


-- Create the user table
drop table if exists raw.tbl_users;

create table raw.tbl_users (
	pinned_tweet_id varchar,
	id varchar,
	username varchar,
	verified varchar,
	name varchar,
	description varchar,
	created_at varchar,
	"public_metrics.followers_count" varchar,
	"public_metrics.following_count" varchar,
	"public_metrics.tweet_count" varchar,
	"public_metrics.listed_count" varchar
);


drop table if exists raw.tbl_tweets;

-- Create the raw tweet table 
create table raw.tbl_tweets (
	user_id varchar,
	id varchar,
	text varchar,
	created_at varchar,
	edit_history_tweet_ids varchar,
	"public_metrics.retweet_count" varchar,
	"public_metrics.reply_count" varchar,
	"public_metrics.like_count" varchar,
	"public_metrics.quote_count" varchar
);


create schema serving;
```

4. Host airbyte on AWS.
5. Team members can then use airbyte to replicate the data in snowflake. 

