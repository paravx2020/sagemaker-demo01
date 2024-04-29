import boto3
import json

def lambda_handler(event, context):
    runtime_client  = boto3.client('runtime.sagemaker')
    endpoint_name   = 'xgboost-2024-xxxxxxxxxxxxxxx' ## to be replaced by actual 
    
    sample          = '1.2, 2.2, 3.3, 4.4'
    response        = runtime_client.invoke_encpoint(EndpointName=endpoint_name, ContentType='text/csv', Body=sample)
    result          = response['Body'].read().decode('ascii')

    print(result)

    retunr {
       'statusCode': 200,
       'body': json.dumps({'prediction': result}) 
    }