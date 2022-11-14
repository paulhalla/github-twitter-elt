#! /usr/bin/env bash

cp -R /opt/airflow/dags/dbt /tmp;
cd /tmp/dbt/data_community;
/usr/local/airflow/dbt_env/bin/dbt build --project-dir /tmp/dbt/data_community/ --profiles-dir . --target dev;
/usr/local/airflow/dbt_env/bin/dbt docs generate;