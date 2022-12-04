import json 
from utilities.get_user_details import get_user_details

def process_streams(json_stream: str) -> dict:
    tweet = json.loads(json_stream)
    user = get_user_details(tweet.get('author_id'))
    combined = {**user, **tweet}

    return combined