#! /usr/bin/env bash

cd /opt/airflow/dags/dbt/data_community
/usr/local/airflow/dbt_env/bin/dbt deps;
/usr/local/airflow/dbt_env/bin/dbt build --profiles-dir . --target dev