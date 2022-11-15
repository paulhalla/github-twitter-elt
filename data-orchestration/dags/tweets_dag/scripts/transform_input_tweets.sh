#! /usr/bin/env bash

cd /opt/airflow/dags/dbt/data_community_input
/usr/local/airflow/dbt_env/bin/dbt deps;
/usr/local/airflow/dbt_env/bin/dbt run --profiles-dir . --target dev;
# cat /tmp/dbt/data_community/logs/dbt.log;