import os 
from auth.auth import BearerTokenAuth



class TestGetUserDetails:

    def setup_class(self):

        consumer_key = os.environ.get('consumer_key')
        consumer_secret = os.environ.get('consumer_secret')

        self.bearer_token = BearerTokenAuth(consumer_key, consumer_secret)


    def test__get_access_token(self):

       assert self.bearer_token != ''





