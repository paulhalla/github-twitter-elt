# How to install `docker-compose`

Learn how to install `docker-compose` [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)


```dockerfile

FROM apache/airflow:2.4.0

RUN pip install --no-cache-dir apache-airflow-providers-slack
RUN pip install --no-cache-dir apache-airflow-providers-airbyte
RUN pip install --no-cache-dir apache-airflow-providers-snowflake


# Install dbt-snowflake in a virtual environment to avoid conflict 
USER root 
ENV PIP_USER=false
RUN python -m venv /usr/local/airflow/dbt_env
RUN /usr/local/airflow/dbt_env/bin/pip install --no-cache-dir dbt-snowflake
ENV PIP_USER=true

USER airflow
```



