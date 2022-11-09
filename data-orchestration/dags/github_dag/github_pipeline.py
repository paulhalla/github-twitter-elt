from airflow import DAG
from airflow.providers.slack.operators.slack_webhook import SlackWebhookOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.utils.trigger_rule import TriggerRule
from airflow.exceptions import AirflowException
from airflow.decorators import task
import pendulum



@task(trigger_rule=TriggerRule.ONE_FAILED)
def watcher():
    raise AirflowException("Failing tasks because an upstream task failed")


with DAG(
    'extract_github_data',
    description='Extract data from Github',
    schedule='@daily',
    start_date=pendulum.datetime(2021, 1, 1, tz='UTC'),
    catchup=False,
    tags=['extraction']
) as dag:

    el_start = SlackWebhookOperator(
        task_id='start_github_extraction',
        http_conn_id='slack_dec',
        message='Extracting github data',
        channel='#project2-group3'
    )

    el_fail_watcher = SlackWebhookOperator(
        task_id='fail_github_extraction',
        http_conn_id='slack_dec',
        message='Github data extracts failed',
        channel='#project2-group3',
        trigger_rule=TriggerRule.ONE_FAILED
    )

    el_end = SlackWebhookOperator(
        task_id='succeed_github_extraction',
        http_conn_id='slack_dec',
        message='Github data extracts succeeded',
        channel='#project2-group3'
    )

    airbyte_conn_id = 'airbyte-connection'
    airbyte_ghsf_conn_id = '14194ac5-e816-4225-9882-c1677566780f'
    trigger_sync = AirbyteTriggerSyncOperator(
        task_id='trigger_sync',
        airbyte_conn_id=airbyte_conn_id,
        connection_id=airbyte_ghsf_conn_id,
        asynchronous=False,
        timeout=3600,
        wait_seconds=3
    )


    el_start >> trigger_sync >> el_end >> el_fail_watcher

    task_list = dag.tasks 
    task_list >> watcher()










