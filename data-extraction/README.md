# Full Extraction of tweets from Twitter 

## Todos

- Host airbyte on AWS.

<br/>

## Done 
- Dockerised extraction. Ready to push to ECR and trigger on ECS with airflow

<br/>

## References 
### s3 
- [How to put a new object in S3](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Object.put)
- [How to put a new object in S3 (StackOverflow)](https://stackoverflow.com/questions/46844263/writing-json-to-file-in-s3-bucket)
- [Uploading files](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-uploading-files.html)

<br/>

### Deploy Airbyte on AWS (EC2)
- https://docs.airbyte.com/deploying-airbyte/on-aws-ec2/
	Make sure to change the password in the `.env` file afterwards.


