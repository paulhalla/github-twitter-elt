import os 
import json
import requests
from auth.auth import BearerTokenAuth



def create_url(user_name='__KingMoh') -> str:

    """ Generate the endpoint to get user details 


    Parameters
    ----------
    user_name: str 
        The username of the user 


    Returns 
    -------
    url: str 
        The generated endpoint 

    """

    usernames = f"usernames={user_name}"
    user_fields = "user.fields=id,description,created_at"
    url = "https://api.twitter.com/2/users/by?{}&{}".format(usernames, user_fields)

    return url



def get_user_details(url: str) -> json:

    """ Get a user's details from twitter 


    Parameters
    ----------
    url: str 
        A valid endpoint that produces the user's details


    Returns
    -------
    user_details: json 
        The user's details in json

    """ 

    # authenticate 
    consumer_key = os.environ.get('consumer_key')
    consumer_secret = os.environ.get('consumer_secret')
    bearer_oauth = BearerTokenAuth(consumer_key, consumer_secret)

    response = requests.request("GET", url, auth=bearer_oauth)

    if response.status_code != 200:
        raise Exception("Request returned an error: {} {}".format(
            response.status_code, response.text
        ))

    return response.json()







