from utilities.get_user import create_url_user, get_user_details
from database.postgres import create_pg_engine
from auth.auth import BearerTokenAuth
from sqlalchemy.dialects import postgresql
import pandas as pd
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

        user = '_KingMoh'
        url = create_url_user(user)

        user_data = get_user_details(url)

        details = pd.json_normalize(user_data.get('data'))

        print(details.columns)

        assert details is not None
        assert len(details.columns) == 11



    def test__save_user_details(self):

        """ save the user's details to postgres """

        user = '_KingMoh'
        url = create_url_user(user)
        user_data = get_user_details(url)
        details = pd.json_normalize(user_data.get('data'))
        engine = create_pg_engine('target')

        rows_returned = details.to_sql('tbl_users', con=engine, schema='raw', if_exists='append', index=False)

        assert rows_returned is not None

        


        







