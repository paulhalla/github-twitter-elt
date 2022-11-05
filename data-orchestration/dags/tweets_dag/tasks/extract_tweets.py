from utilities.get_user import create_url_user, get_user_details 
from utilities.get_tweets_by_user import create_url_tweets, get_user_tweets
from random import randrange
import boto3
import yaml
import logging
import json
import time


def extract():

    with open('/opt/airflow/dags/tweets_dag/tasks/config.yaml', 'r') as file:
        config = yaml.safe_load(file)

    # s3 bucket config
    s3 = boto3.resource('s3')
    bucket_name = config.get('s3').get('bucket_name')
    users_folder = config.get('s3').get('users_folder')
    tweets_folder = config.get('s3').get('tweets_folder')


    
    # set up logging
    logging.basicConfig(level=logging.INFO, format="[%(levelname)s][%(asctime)s]: %(message)s")


    # Twitter handles of data influencers
    twitter_handles_location = config.get('twitter_handles').get('location')
    with open(twitter_handles_location, 'r') as file:
        user_handles = file.readlines()
        cleaned_handles = [user.split('.com/')[-1].strip().replace('/','') for user in user_handles]


    # keep track of requests
    num_of_tweet_requests = 0
    num_of_user_requests = 0


    for user in cleaned_handles[:10]:

        time.sleep(randrange(2, 5))

        users3Object = s3.Object(bucket_name, f'{users_folder}/{user}.json')
        tweets3Object = s3.Object(bucket_name, f'{tweets_folder}/{user}.json')

        logging.info(f'Getting tweets for {user}')
        
        user_url = create_url_user(user_name=user)
        user_details = get_user_details(user_url)

        tweet_url = create_url_tweets(user_details.get('data')[0].get('id'))

        # get some tweets
        twitter_config = config.get('tweet_period_config')
        tweets = get_user_tweets(tweet_url, params=twitter_config)

        # increment requests 
        num_of_tweet_requests += 1
        num_of_user_requests += 1

        # 300 requests/15 minutes
        if num_of_user_requests % 10 == 0:
            logging.info(f'Max endpoint hits for users have been reached. Sleeping for 15 minutes')
            time.sleep(10)


        if tweets.get('meta').get('result_count') == 0:
            logging.info(f'{user} has no tweets between {config.get("tweet_period_config").get("start_time")} and {config.get("tweet_period_config").get("end_time")}')
            logging.info(f'Number of requests: Users={num_of_user_requests} Tweets={num_of_tweet_requests}')
            continue


        # Save records
        try:
            users3Object.put(
                Body=(bytes(json.dumps(user_details).encode('UTF-8')))
            )
            logging.info(f'Successfully saved user details of {user} at s3://{bucket_name}/{users_folder}/{user}.json')

            tweets3Object.put(
                Body=(bytes(json.dumps(tweets).encode('UTF-8')))
            )
            logging.info(f'Successfully saved tweets for user: {user} at s3://{bucket_name}/{tweets_folder}/{user}.json')

        
        except BaseException as err:
            logging.exception(err)
            return None

        time.sleep(randrange(2, 5))


        # Get more tweets if possible
        while True:

            # 900 requests/15 minutes
            if num_of_tweet_requests % 70 == 0:
                logging.info(f'Max endpoint hits for tweets have been reached. Sleeping for 15 minutes')
                time.sleep(200)

            if tweets.get('meta').get('next_token'):

                twitter_config['pagination_token'] = tweets.get('meta').get('next_token')
                tweets = get_user_tweets(tweet_url, params=twitter_config)

                num_of_tweet_requests += 1

                # Save records
                try:
                    tweets3Object = s3.Object(bucket_name, f'{tweets_folder}/{user}-{twitter_config.get("pagination_token")}.json')
                    tweets3Object.put(
                        Body=(bytes(json.dumps(tweets).encode('utf-8')))
                    )
                    logging.info(f'Successfully saved tweets from next page for user: {user} at s3://{bucket_name}/{tweets_folder}/{user}-{twitter_config.get("pagination_token")}.json')
                    logging.info(f'Number of requests: Users={num_of_user_requests} Tweets={num_of_tweet_requests}')

                    time.sleep(randrange(3, 6))
                
                except BaseException as err:
                    logging.exception(err)
                    return None

                continue 

            break

    
    return True








