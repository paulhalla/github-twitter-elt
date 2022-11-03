#!/bin/bash

docker build -t twitter-extracts .
docker run --env-file .env twitter-extracts


