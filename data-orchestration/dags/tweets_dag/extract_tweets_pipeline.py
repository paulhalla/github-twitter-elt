from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.providers.slack.operators.slack_webhook import SlackWebhookOperator
from airflow.utils.trigger_rule import TriggerRule
from airflow.exceptions import AirflowException
from airflow.decorators import task
from airflow.models import Variable
from tweets_dag.tasks.extract_tweets import extract
import pendulum
import json



@task(trigger_rule=TriggerRule.ONE_FAILED)
def watcher():
    raise AirflowException("Failing tasks because an upstream task failed")


with DAG(
    'extract_tweets',
    description='Extract tweets from Twitter',
    schedule='0 */2 * * *',
    start_date=pendulum.datetime(2022, 1, 1, tz='UTC'),
    catchup=False,
    tags=['extraction']
) as dag:

    el_start = SlackWebhookOperator(
        task_id='twitter_extracts_start',
        http_conn_id='slack_dec',
        message='Twitter extracts started',
        channel='#project2-group3'
    )

    el_fail_watcher = SlackWebhookOperator(
        task_id='twitter_extracts_fail',
        http_conn_id='slack_dec',
        message='Twitter extracts failed',
        channel='#project2-group3',
        trigger_rule=TriggerRule.ONE_FAILED
    )

    el_end = SlackWebhookOperator(
        task_id='twitter_extracts_end',
        http_conn_id='slack_dec',
        message='Twitter extracts ended',
        channel='#project2-group3'
    )

    extract_tweets = PythonOperator(
        task_id='extract_tweets',
        python_callable=extract
    )

    # dbt_env_json = Variable.get("DBT_ENV", deserialize_json=True)

    # dbt_version = BashOperator(
    #     task_id='dbt_version',
    #     bash_command='/usr/local/airflow/dbt_env/bin/dbt --version',
    #     env=dbt_env_json
    # )

    # dbt_build = BashOperator(
    #     task_id='dbt_build',
    #     env=dbt_env_json,
    #     bash_command='/opt/airflow/dags/tweets_dag/scripts/transform_tweets.sh '
    # )

    # dbt_version >> dbt_build

    el_start >> extract_tweets >> el_end >> el_fail_watcher

    task_list = dag.tasks 
    task_list >> watcher()












