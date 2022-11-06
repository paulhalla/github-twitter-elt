<br/>

# Helpful References

<blockquote style='font-size:2.5rem'>Think of <b>Idempotence</b> in the design of your DAGS </blockquote>

*Heng Ji*

<br/>

# Setting up Airflow on an EC2 instance

1. Provision a t2.medium EC2 instance with a Ubuntu image.
2. Make sure to download a certificate for authentication.
3. Once the EC2 instance is provisioned, go [here](https://docs.airbyte.com/deploying-airbyte/on-aws-ec2/) to learn how to login.
4. Follow [this](https://docs.docker.com/engine/install/ubuntu/) to learn how to install docker.
5. Learn how to install `docker-compose` [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)
6. [Install](https://github.com/git-guides/install-git)  git to pull the repo.
7. [Run Airflow with `docker-compose`](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html)
8. Navigate to the project (`dec-project-2/data-orchestration`) and run `sudo docker-compose up -d` to start all the airflow services.


<br/>

# Airflow fundamental concepts
- https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html

<br/>

# Pipeline development workflow

## Running recent changes
- Pull recent changes from [main](https://github.com/paulhalla/dec-project-2)
- Do not run the DAG locally. (Open to ideas)

## Push changes
- Make your task changes.
- Test your task changes. You can run your dag on a standalone server

	```bash 
	docker run -p 8070:8080 -v /$(pwd):/opt/airflow --env-file .env  extended-airflow standalone
	```

	`exec` into the running container and run a test.

	```bash 
	docker exec -it container-name bash;

	airflow dags test dag-id [run_date]
	```
- Submit your task changes and tests for review (add screenshots if necessary)
- Get a reviewer to merge your changes.

<br/>


# How to structure DBT Projects
- [Why does structure matter?](https://docs.getdbt.com/guides/best-practices/how-we-structure/1-guide-overview)


<br/>

# Dockerfile that installs DBT in a virtual environment 

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

<br/>


# Introduction to Snowpipe 

- [Introduction to Snowpipe](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-intro.html)
- [Automating Snowpipe for Amazon S3](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-auto-s3.html)
- [Overview of the Snowpipe REST Endpoints to Load Data](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-rest-overview.html)
- [Loading data using the Snowpipe REST API](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-rest-load.html#sample-program-for-the-python-sdk)
- [Preparing to Load Data using Snowpipe](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-rest-gs.html#using-key-pair-authentication-key-rotation)

<br/>

# Installation of AWS CLI and Configuration basics
- [Configuration Basics](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- [AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

<br/>


# Configs
## Start airbyte when the ec2 instance is rebooted

`$HOME/start_up/start_up.sh`

```bash

#!/bin/bash 

# start the docker service 
sudo service docker start 

# run docker-compose in the background 
cd $HOME/airbyte
docker-compose up -d

```


`crontab`
```bash 
@reboot sh $HOME/start_up/start_up.sh
```
<br/>

## Pull recent changes from the main branch 
Same as above.
