from utilities.get_user import create_url_user, get_user_details
from auth.auth import BearerTokenAuth
import requests
import os


class TestGetUserDetails:

    def setup_class(self):

        consumer_key = os.environ.get('consumer_key')
        consumer_secret = os.environ.get('consumer_secret')

        self.bearer_token = BearerTokenAuth(consumer_key, consumer_secret)



    def test__get_url_for_user_details(self):

        user = '__KingMoh'
        url = create_url_user(user)

        assert user != ''
        assert user in url 



    def test__get_user_details(self):

        user = '__KingMoh'
        url = create_url_user(user)

        details = get_user_details(url)

        assert details is not None






