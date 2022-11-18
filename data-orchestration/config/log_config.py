# -*- coding: utf-8 -*-
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
from airflow.config_templates.airflow_local_settings import DEFAULT_LOGGING_CONFIG
from airflow import configuration as conf
from copy import deepcopy

# TODO: Logging format and level should be configured
# in this file instead of from airflow.cfg. Currently
# there are other log format and level configurations in
# settings.py and cli.py. Please see AIRFLOW-1455.

S3_LOG_FOLDER = 's3://decbrismoh-snowflake/dec-project-2/airflow-logs/'

LOG_LEVEL = conf.get('logging', 'LOGGING_LEVEL').upper()
LOG_FORMAT = conf.get('logging', 'log_format')

BASE_LOG_FOLDER = conf.get('logging', 'BASE_LOG_FOLDER')
PROCESSOR_LOG_FOLDER = conf.get('scheduler', 'child_process_log_directory')

FILENAME_TEMPLATE = '{{ ti.dag_id }}/{{ ti.task_id }}/{{ ts }}/{{ try_number }}.log'
PROCESSOR_FILENAME_TEMPLATE = '{{ filename }}.log'


LOGGING_CONFIG = deepcopy(DEFAULT_LOGGING_CONFIG)


# Add a formatter 
LOGGING_CONFIG['formatters']['airflow.task'] = { 'format': LOG_FORMAT }
LOGGING_CONFIG['formatters']['airflow.processor'] = { 'format': LOG_FORMAT }

# Add an S3 task handler
LOGGING_CONFIG['handlers']['s3.task'] = {
    'class': 'airflow.providers.amazon.aws.log.s3_task_handler.S3TaskHandler',
    'formatter': 'airflow.task',
    'base_log_folder': os.path.expanduser(BASE_LOG_FOLDER),
    's3_log_folder': S3_LOG_FOLDER,
    'filename_template': FILENAME_TEMPLATE
}

# Add logger 
LOGGING_CONFIG['loggers']['airflow.task']['handlers'] = ['task', 's3.task']
