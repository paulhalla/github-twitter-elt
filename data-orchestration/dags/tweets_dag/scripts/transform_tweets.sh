#! /usr/bin/env bash

cp -R /opt/airflow/dags/dbt /tmp;
cd /tmp/dbt/data_community;
/usr/local/airflow/dbt_env/bin/dbt deps;
/usr/local/airflow/dbt_env/bin/dbt run --select +all_top_tweets --project-dir /tmp/dbt/data_community/ --profiles-dir . --target dev;
# cat /tmp/dbt/data_community/logs/dbt.log;