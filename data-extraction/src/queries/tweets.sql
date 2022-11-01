
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
