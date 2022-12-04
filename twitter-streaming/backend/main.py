from fastapi import FastAPI 
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import requests
import logging
import os 

logging.basicConfig(format='%(levelname)s:    %(message)s', level=logging.DEBUG)


class Token(BaseModel):
    token: str


app = FastAPI()

origins = [
    "http://localhost:3000"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get('/')
def welcome():
    return 'Welcome home'

@app.get('/recent_events')
def get_recent_events():

    base_url = 'https://qega1y8l6b.ap-southeast-1.aws.clickhouse.cloud:8443/'
    params = {
        "user": "default",
        "password": os.environ.get('CLICKHOUSE_PASS'),
        "query": "select top 10 * from tweets where username <> '' order by created_at desc format JSON"
    }

    try:
        response = requests.get(base_url, params=params)

        if response.status_code != 200:
            raise Exception("Unexpected response status code")

    except BaseException as err:
        logging.error(err)

    else:
        return response.json().get('data')

    
@app.get('/access')
def get_access_token():

    base_url = 'http://localhost:8088/api/v1/security/login'
    payload = {
        "password": "admin",
        "username": "admin",
        "provider": "db",
        "refresh": "true"
    }

    headers = {
        "Content-Type": "application/json"
    }

    response = requests.post(base_url, json=payload, headers=headers)

    if response.status_code != 200:
        raise Exception("Access token was not granted")
    
    return response.json()


@app.post('/access_guest')
def get_guest_token(token: Token):

    base_url = 'http://localhost:8088/api/v1/security/guest_token'
    payload = {
        "user": {
            "username": "worldCupUser", 
            "first_name": "WorldCup", 
            "last_name": "WorldCup"
        }, 
        "resources":[
            {
                "type": "dashboard", 
                "id": "19226426-1072-41af-9a76-5320e372503a"
            }
        ],
        "rls": []
    }

    headers = {
        "Authorization": f"Bearer {token.token}"
    }

    response = requests.post(base_url, json=payload, headers=headers)
    
    if response.status_code != 200:
        raise Exception('Guest token was not generated')

    return response.json()