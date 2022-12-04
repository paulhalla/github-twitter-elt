from typing import Union 
from fastapi import FastAPI 
from pydantic import BaseModel
from enum import Enum 
import requests
import os 

class ModelName(str, Enum):
    alexnet = "alexnet"
    resnet = "resnet"
    lenet = "lenet"


app = FastAPI()

@app.get('/recent_events')
def get_recent_events():

    base_url = 'https://qega1y8l6b.ap-southeast-1.aws.clickhouse.cloud:8443/'
    params = {
        "user": "default",
        "password": os.environ.get('CLICKHOUSE_PASS'),
        "query": "select top 10 * from tweets order by created_at desc format JSON"
    }
    response = requests.get(base_url, params=params)

    return response.json().get('data')
