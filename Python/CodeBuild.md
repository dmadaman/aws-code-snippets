Start a CodeBuild job:
```
cb_client 	      = boto3.client('codebuild', region_name=REGION)
REGION				    = os.environ['REGION_NAME']
CODEBUILD_PROJECT	= os.environ['CODEBUILD_PROJECT_NAME']

def StartBuild():
	try:
		response = cb_client.start_build(projectName=CODEBUILD_PROJECT)
	except ClientError as err:
		print(err.response['Error']['Message'])
	else:
		print("StartBuild succeeded:")
		print(" - Build ID: {}".format(response['build']['id']))
		print(" - ARN: {}".format(response['build']['arn']))
		print(" - Start Time: {}".format(response['build']['startTime']))
		print(" - Build Status {}".format(response['build']['buildStatus']))

```