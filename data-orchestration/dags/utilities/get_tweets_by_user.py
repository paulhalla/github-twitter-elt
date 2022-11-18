import requests
import os
import json
import logging
from auth.auth import BearerTokenAuth

# set up logging
logging.basicConfig(level=logging.INFO, format="[%(levelname)s][%(asctime)s]: %(message)s")


def create_url_tweets(user_id: str) -> str:

    """ Generate the endpoint to get a user's tweets 


    Parameters
    ----------

    user_id: str 
        The user id 


    Returns
    -------
    url: str 
        A valid endpoint that produces the user's details

    """ 
    # reference: https://developer.twitter.com/en/docs/twitter-api/fields
    tweet_fields = "tweet.fields=created_at,public_metrics"

    return 'https://api.twitter.com/2/users/{}/tweets?{}'.format(user_id, tweet_fields)




def get_user_tweets(url: str, params: dict=None) -> json:

    """ Get a user's tweets


    Parameters
    ----------
    url: str 
        A valid endpoint that produces a user's tweets


    Returns
    -------
    tweets: json 
        The users tweets 

    """

    consumer_key = os.environ.get('consumer_key')
    consumer_secret = os.environ.get('consumer_secret')
    bearer_token = BearerTokenAuth(consumer_key, consumer_secret)


    if params is not None:
        response = requests.request('GET', url, auth=bearer_token, params=params)

    else:
        response = requests.request('GET', url, auth=bearer_token)


    if response.status_code != 200:
        logging.error("Request returned an error: {} {}".format(
            response.status_code, response.text
        ))

    return response.json()


