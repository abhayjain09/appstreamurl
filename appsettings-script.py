import json

appsettings_file = open("./appsettings.json", "r")
output_terraform_file = open("./output.json", "r")
appsettings_json_object = json.load(appsettings_file)
output_terraform_json_object = json.load(output_terraform_file)
appsettings_file.close()
output_terraform_file.close()
pool = (output_terraform_json_object['user_pool_client'])
pool = pool['value']
#print(pool)
region = pool['region']
userpool_name = (pool['userpool_name'])
api_gateway_id = pool['api_gateway']
appsettings_json_object['AppConfig']['Environment'] = pool['Environment']
appsettings_json_object['AppConfig']['Cognito']['loginUrl'] = (("https://"+userpool_name+".auth."+region+".amazoncognito.com/login").lower())
appsettings_json_object['AppConfig']['Cognito']['tokenUrl'] = (("https://"+userpool_name+".auth."+region+".amazoncognito.com/oauth2/token").lower())
appsettings_json_object['AppConfig']['Cognito']['Clients']['UatClient']['ClientId'] = pool['ClientId']
appsettings_json_object['AppConfig']['Cognito']['Clients']['UatClient']['ClientSecret'] = pool['ClientSecret']
appsettings_json_object['AppConfig']['AppStream']['GenerateStreamingUrlEndPoint'] = "https://"+api_gateway_id+".execute-api."+region+".amazonaws.com/Appstream/Url"


json_file = open("./appsettings.json", "w")
json.dump(appsettings_json_object, json_file)
json_file.close()
