<br/>

# Setting up Airflow on an EC2 instance

1. Provision a t2.medium EC2 instance with a Ubuntu image.
2. Make sure to download a certificate for authentication.
3. Once the EC2 instance is provisioned, go [here](https://docs.airbyte.com/deploying-airbyte/on-aws-ec2/) to learn how to login.
4. Follow [this](https://docs.docker.com/engine/install/ubuntu/) to learn how to install docker.
5. Learn how to install `docker-compose` [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)
6. [Install](https://github.com/git-guides/install-git)  git to pull the repo.
7. Navigate to the project (`dec-project-2/data-orchestration`) and run `sudo docker-compose up -d` to start all the airflow services.


<br/>

# Dockefile that installs DBT in a virtual environment r

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

<br/>


# An example of a DBT Build

```python 

dbt_env_json = '{{ var.json.DBT_ENV }}'

dbt_build = BaseOperator(
  task_id='dbt_build',
  env=dbt_env_json,
  bash_command="
      cp -R /opt/airflow/dags/dbt /tmp;\
      cd /tmp/dbt/decdotcom;\
      /usr/local/airflow/dbt_env/bin/dbt deps;\
      /usr/local/airflow/dbt_env/dbt build --project-dir /tmp/dbt/decdotcom/ --profiles-dir . --target prod;\
      cat /tmp/dbt_logs/dbt.log;
  ")
```


