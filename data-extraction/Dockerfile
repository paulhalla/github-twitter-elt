FROM --platform=linux/amd64 python:3.9 

WORKDIR /src 

COPY /src . 

RUN pip install -r requirements.txt 

ENV PYTHONPATH=/src

CMD ["python", "pipeline/extract_tweets_pipeline.py"]
