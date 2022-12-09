import json 
import logging 
from utilities.get_user_details import get_user_details


def process_streams(json_stream: str) -> dict:

    """
    Enrich a tweet by adding user details 

    Parameters
    ----------
    json_stream: str 
        A json string of tweet details 

    
    Returns
    -------
    data: dict 
        Enriched tweet 
    """
    tweet = json.loads(json_stream)

    try:
        user = get_user_details(tweet.get('author_id'))
    except AttributeError as err:
        logging.error('author_id is not an attribute in json_stream')

    if user is None:
        data = tweet 
        return data
    
    data = {**user, **tweet}
    return data