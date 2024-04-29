import boto3
import json
import ast

def lambda_handler(event, context):
    runtime_client  = boto3.client('runtime.sagemaker')
    endpoint_name   = 'xgboost-2024-04-29-15-41-25-374' ## to be replaced by actual 
    
    sample          = '7.7, 2.8, 6.7, 2.0'
    #sample          = '{},{},{},{}'.format(ast.literal_eval(event[body])['x1'], ast.literal_eval(event[body])['x2'], ast.literal_eval(event[body])['x3'], ast.literal_eval(event[body])['x4'])
                                            
    response        = runtime_client.invoke_endpoint(EndpointName=endpoint_name, ContentType='text/csv', Body=sample)
    result          = response['Body'].read().decode('ascii')

    print(result)

    return {
       'statusCode': 200,
       'body': json.dumps({'prediction': result}) 
    }