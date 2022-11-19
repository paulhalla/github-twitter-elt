from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.providers.slack.operators.slack_webhook import SlackWebhookOperator
from airflow.utils.trigger_rule import TriggerRule
from airflow.exceptions import AirflowException
from airflow.decorators import task
from airflow.models import Variable
from dbt_docs_dag.tasks.push_docs import push_docs
import pendulum



@task(trigger_rule=TriggerRule.ONE_FAILED)
def watcher():
    raise AirflowException("Failing tasks because an upstream task failed")


# Decide on a good frequency
with DAG(
    'serve_docs',
    description='Serve dbt Documentation site',
    schedule='@daily',
    start_date=pendulum.datetime(2022, 1, 1, tz='UTC'),
    catchup=False,
    tags=['documentation']
) as dag:

    el_start = SlackWebhookOperator(
        task_id='docs_update_started',
        http_conn_id='slack_dec',
        message='Updating dbt docs',
        channel='#project2-group3'
    )

    el_fail_watcher = SlackWebhookOperator(
        task_id='docs_update_failed',
        http_conn_id='slack_dec',
        message='Dbt docs update failed',
        channel='#project2-group3',
        trigger_rule=TriggerRule.ONE_FAILED
    )

    el_end = SlackWebhookOperator(
        task_id='docs_update_succeeded',
        http_conn_id='slack_dec',
        message='Dbt docs update succeeded',
        channel='#project2-group3'
    )

    push_docs_to_s3 = PythonOperator(
        task_id='push_docs_to_s3',
        python_callable=push_docs
    )

    dbt_env_json = Variable.get("dbt_ENV", deserialize_json=True)

    dbt_docs_generate = BashOperator(
        task_id='dbt_docs_generate',
        bash_command="/opt/airflow/dags/dbt_docs_dag/scripts/generate_docs.sh "
    )

    el_start >> dbt_docs_generate >> push_docs_to_s3 >> el_end >> el_fail_watcher

    task_list = dag.tasks 
    task_list >> watcher()