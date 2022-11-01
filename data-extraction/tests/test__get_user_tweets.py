from utilities.get_user import create_url_user, get_user_details
from utilities.get_tweets_by_user import create_url_tweets, get_user_tweets
from auth.auth import BearerTokenAuth
from database.postgres import create_pg_engine
import pandas as pd
import requests 
import os 


class TestGetTweets:


    def setup_class(self):

        consumer_key = os.environ.get('consumer_key')
        consumer_secret = os.environ.get('consumer_secret')

        self._bearer_token = BearerTokenAuth(consumer_key, consumer_secret)



    def test__get_user_id(self):

        url = create_url_user(user_name='_KingMoh')

        # get the details of the user
        user_id = get_user_details(url).get('data')[0].get('id')

        assert user_id is not None



    def test__get_user_tweets_url(self):

        user_url = create_url_user(user_name='_KingMoh')
        user_id = get_user_details(user_url).get('data')[0].get('id')

        # generate the endpoint to get the user's tweets
        tweet_url = create_url_tweets(user_id)

        assert tweet_url is not None



    def test__get_user_tweets(self):

        engine = create_pg_engine()
        user_url = create_url_user(user_name='TwitterDev')
        user_id = get_user_details(user_url).get('data')[0].get('id')

        # use pagination to get all tests over a period
        # reference: https://developer.twitter.com/en/docs/twitter-api/pagination
        params = {
            'start_time': '2019-01-01T00:00:00Z',
            'end_time': '2020-01-10T23:59:00Z',
            'max_results': 100,
            'pagination_token': None
        }

        # generate the endpoint to get the user's tweets
        tweet_url = create_url_tweets(user_id)

        # get some tweets 
        tweets = get_user_tweets(tweet_url, params=params)
        
        data_df = pd.json_normalize(tweets.get('data'))
        meta_data = pd.json_normalize(tweets.get('meta'))
        data_df['user_id'] = user_id

        while True:

            if tweets.get('meta').get('next_token'):

                params = {
                    'start_time': '2019-01-01T00:00:00Z',
                    'end_time': '2020-01-10T23:59:00Z',
                    'max_results': 100,
                    'pagination_token': tweets.get('meta').get('next_token')
                }

                tweets = get_user_tweets(tweet_url, params=params)
                data_df = pd.concat([data_df, pd.json_normalize(tweets.get('data'))])
                data_df['user_id'] = user_id

                continue

            break


        print(tweets)
        exit()
            

        rows_returned = data_df.to_sql('tbl_tweets', con=engine, schema='raw', if_exists='replace', index=False)

        assert rows_returned is None
        assert user_id is not None


