from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.slack.operators.slack_webhook import SlackWebhookOperator
from airflow.utils.trigger_rule import TriggerRule
from airflow.exceptions import AirflowException
from airflow.decorators import task
from tweets_dag.tasks.extract_tweets import extract
import pendulum



@task(trigger_rule=TriggerRule.ONE_FAILED)
def watcher():
    raise AirflowException("Failing tasks because an upstream task failed")


with DAG(
    'extract_tweets',
    description='Extract tweets from Twitter',
    schedule='@daily',
    start_date=pendulum.datetime(2021, 1, 1, tz='UTC'),
    catchup=False,
    tags=['extraction']
) as dag:

    # el_start = SlackWebhookOperator(
    #     task_id='twitter_extracts_start',
    #     http_conn_id='slack_dec',
    #     message='Twitter extracts started',
    #     channel='#project2-group3'
    # )

    # el_fail_watcher = SlackWebhookOperator(
    #     task_id='twitter_extracts_fail',
    #     http_conn_id='slack_dec',
    #     message='Twitter extracts failed',
    #     channel='#project2-group3',
    #     trigger_rule=TriggerRule.ONE_FAILED
    # )

    # el_end = SlackWebhookOperator(
    #     task_id='twitter_extracts_end',
    #     http_conn_id='slack_dec',
    #     message='Twitter extracts ended',
    #     channel='#project2-group3'
    # )

    extract_tweets = PythonOperator(
        task_id='extract_tweets',
        python_callable=extract
    )

    # el_start >> extract_tweets >> el_end

    # task_list = dag.tasks 
    # task_list.remove(el_fail_watcher)
    # task_list >> el_fail_watcher >> watcher()










