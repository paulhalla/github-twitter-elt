from requests.auth import AuthBase
import requests

class BearerTokenAuth(AuthBase):

    def __init__(self, consumer_key, consumer_secret):
        self.bearer_token_url = 'https://api.twitter.com/oauth2/token'
        self.consumer_key = consumer_key
        self.consumer_secret = consumer_secret
        self.bearer_token = self._get_bearer_token()



    def _get_bearer_token(self):
        response = requests.post(
                self.bearer_token_url,
                auth = (self.consumer_key, self.consumer_secret),
                data = {"grant_type": "client_credentials"},
                headers = {"User-Agent": "TwitterDevFilteredStreamQuickStartPython"}
        )

        if response.status_code != 200:
            raise Exception(f"Cannot get Bearer token (HTTP %d): %s" % (response.status_code, response.text))

        body = response.json()
        return body['access_token']


    def __call__(self, r):
        r.headers['Authorization'] = f'Bearer %s' % self.bearer_token
        r.headers['User-Agent'] = 'TwitterDevFilteredStreamQuickStartPython'
        return r
