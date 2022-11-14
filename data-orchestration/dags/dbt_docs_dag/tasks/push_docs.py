
def push_docs():

    import logging
    import boto3 
    import yaml
    from botocore.exceptions import ClientError

    with open('/opt/airflow/dags/dbt_docs_dag/tasks/config.yaml', 'r') as file:
        config = yaml.safe_load(file)


    # s3 bucket config
    s3_client = boto3.client('s3')
    bucket_name = config.get('s3').get('bucket_name')
    serving_folder = config.get('s3').get('serving_folder')

    # set up logging
    logging.basicConfig(level=logging.INFO, format="[%(levelname)s][%(asctime)s]: %(message)s")

    # list files
    serving_files = [file for file in config.get('s3').get('docs_files')]

    # serving files path 
    serving_files_path = config.get('s3').get('docs_files_path')

    # push the files 
    for s3_file in serving_files:
        try:
            s3_client.upload_file(f'{serving_files_path}/{s3_file}', bucket_name, f'{s3_file}', ExtraArgs={'ContentType':'text/html'})
            logging.info(f'Successfully pushed {s3_file} to s3://{bucket_name}/{s3_file}')
        except ClientError as e:
            logging.error(e)
            return False 

    return True

