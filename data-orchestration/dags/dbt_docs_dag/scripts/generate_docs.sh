#! /usr/bin/env bash

if [ -d "/tmp/dbt" ]
then
  echo "dbt project already exists"
else
  cp -R /opt/airflow/dags/dbt /tmp
fi 

cd /tmp/dbt/data_community 
/usr/local/airflow/dbt_env/bin/dbt docs generate --profiles-dir /opt/airflow/dags/dbt/data_community
