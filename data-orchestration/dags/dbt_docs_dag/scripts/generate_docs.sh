#! /usr/bin/env bash

cd /opt/airflow/dags/dbt/data_community 
/usr/local/airflow/dbt_env/bin/dbt build --profiles-dir . --target prod
/usr/local/airflow/dbt_env/bin/dbt docs generate --profiles-dir . --target prod
