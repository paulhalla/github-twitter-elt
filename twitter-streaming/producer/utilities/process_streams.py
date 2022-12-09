import json 
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
    user = get_user_details(tweet.get('author_id'))

    if user is None:
        data = tweet 
        return data
    
    data = {**user, **tweet}
    return data