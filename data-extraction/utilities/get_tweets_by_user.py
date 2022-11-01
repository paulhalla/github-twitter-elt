import requests
import os
import json
from auth.auth import BearerTokenAuth



def create_url(user_id: str) -> str:

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


def get_params():

    return {"tweet.fields":; "created_at"}



def get_user_tweets(url: str) -> json:

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

    response = requests.request('GET', url, auth=bearer_token)

    if response.status_code != 200:
        raise Exception("Request returned an error: {} {}".format(
            response.status_code, response.text
        ))

    return response.json()








