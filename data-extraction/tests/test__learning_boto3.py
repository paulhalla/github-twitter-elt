import boto3

class TestLoadJSONToBoto3:


    def test__print_all_buckets(self):

        s3 = boto3.resource('s3')

        for bucket in s3.buckets.all():
            print(bucket.name)

        assert True == True


        




    def test__upload_file_to_bucket(self):

        s3 = boto3.resource('s3')
        success = False

        try:
            data = open('./sample.json', 'rb')
            s3.Bucket('decbrismoh-snowflake').put_object(Key='dec-project-2/sample.json', Body=data)

        except BaseException as err:
            print(err)
            success = False 

        else:
            success = True 


        assert success == True




