#! /usr/bin/env bash

if [ -d "/tmp/dbt" ]
then
    cd /tmp/dbt/data_community;
    /usr/local/airflow/dbt_env/bin/dbt source freshness --profiles-dir /opt/airflow/dags/dbt/data_community --target prod
else
  echo "dbt project does not exist"
  exit 1
fi 

