#! /usr/bin/env bash

cp -R /opt/airflow/dags/dbt /tmp;
cd /tmp/dbt/data_community;
/usr/local/airflow/dbt_env/bin/dbt docs generate;