from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.providers.slack.operators.slack_webhook import SlackWebhookOperator
from airflow.utils.trigger_rule import TriggerRule
from airflow.models import Variable
from tweets_dag.tasks.extract_tweets import extract
import pendulum



with DAG(
    'extract_tweets',
    description='Extract tweets from Twitter',
    schedule='@daily',
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
        message='An upstream task failed. View logs',
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

    dbt_env_json = Variable.get("DBT_ENV", deserialize_json=True)


    # check source freshness
    dbt_freshness = BashOperator(
        task_id='dbt_freshness',
        bash_command="/opt/airflow/dags/tweets_dag/scripts/check_source_freshness.sh "
    )

    twitter_dbt_run_prior = BashOperator(
        task_id='build_input_tweet_tables',
        env=dbt_env_json,
        bash_command='/opt/airflow/dags/tweets_dag/scripts/transform_input_tweets.sh '
    )

    twitter_dbt_run = BashOperator(
        task_id='twitter_dbt_run',
        env=dbt_env_json,
        bash_command='/opt/airflow/dags/tweets_dag/scripts/transform_tweets.sh ',
    )

    el_start >> extract_tweets >> twitter_dbt_run_prior >> dbt_freshness >> twitter_dbt_run >> el_end >> el_fail_watcher


















