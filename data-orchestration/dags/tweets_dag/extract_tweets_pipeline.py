from airflow import DAG
from airflow.operators.python import PythonOperator
from tweets_dag.tasks.extract_tweets import extract
import pendulum



with DAG(
    'extract_tweets',
    description='Extract tweets from Twitter',
    schedule='@daily',
    start_date=pendulum.datetime(2021, 1, 1, tz='UTC'),
    catchup=False,
    tags=['extraction']
) as dag:

    extract_tweets = PythonOperator(
        task_id='extract_tweets',
        python_callable=extract
    )






