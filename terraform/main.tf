data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "cognito" {
  source = "./cognito"
  name = var.userpool_name
  region = var.region
  enable_anonymous_access = false # a value indicating whether or not to enable anonymous access

  # enable oidc integration and customisation
  #oidc_provider      = var.oidc_provider                           # name of the provider, default: SAM-IS
  #oidc_client_id     = var.oidc_client_id      # enable oidc integration with cognito
  #oidc_client_secret =   var.oidc_client_secret    # enable oidc integration with cognito
  #oidc_scopes        = ["profile", "email", "openid"]                                   # default: openid profile email
  oidc_issuer        = var.oidc_issuer     #"https://sam.samexternal.net:443/sso/oauth2" # the URL of the oidc issuer, default: https://sam.ihsmarkit.com:443/sso/oauth2
  #oidc_callback_urls = ["https://example.blueprints.network/oauth2/idpresponse"]
  oidc_callback_urls = [var.oidc_callback_urls]
  # TIP: use the hierarchy module to generate tags that comply with policies
  # module.hierarchy.tags
  tags = var.tags # the tags to apply to all resources

  #need to delete
  auth_google_client_id     = "1074978038016-5q26uf1qkblsj6agkbj0v5dqbhje352r.apps.googleusercontent.com"
  auth_google_client_secret = "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"
}

module "GenerateAppStreamUrl" {
  source = "./Lambda/lambda"
  name       = "GenerateAppStreamUrl"
  source_dir = "./GenerateAppStreamUrl"
  handler    = "index.handler"
  runtime    = "nodejs14.x"
  region     = var.region
  policy_arns = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonAppStreamFullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
  ]
  tags = var.tags # the tags to apply to all resources.

  # optional variables  
  memory_size      = 128
  timeout          = 600
  description      = "Generate an temporary appstream url and return it."
  policy_documents = [] #put policy document in json format if you need to attach any inline policy
}

module "apigateway_AppstreamUrlAutomation" {
  source = "./apigateway"
  audience = ["${module.cognito.user_pool_client.client_id}"]
  issuer = "https://${module.cognito.user_pool_client.endpoint}"
  GenerateAppStreamUrl-name = module.GenerateAppStreamUrl.name
  tags = var.tags
}



#need to check  #need to delete
resource "aws_api_gateway_domain_name" "example" {
  domain_name              = "appstream.gurudevhardware.online"
  regional_certificate_arn = "arn:aws:acm:us-east-1:459028066127:certificate/f0f6ce0a-1d0b-48a6-8823-af0c60b86a9e"
  security_policy          = "TLS_1_2"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

module "AppStreamUrl_Route53HealthCheck" {

  source = "./Lambda/lambda"
  # required variables
  name        = "AppStreamUrl-Route53HealthCheck"
  source_dir  = "./AppStreamUrl-Route53HealthCheck"
  handler     = "index.handler"
  runtime     = "nodejs14.x"
  policy_arns = ["arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"]
  tags        = var.tags # the tags to apply to all resources.
  # optional variables  
  memory_size      = 128
  timeout          = 20
  region           = var.region
  description      = "Used for Route53 health check. A simple health check returning hello world"
  policy_documents = [] #put policy document in json format if you need to attach any inline policy
}

module "AppStreamUrl_Route53HealthCheck_apigateway" {
  source = "./Route53-healthcheck"
  AppStreamUrl_Route53HealthCheck_name = module.AppStreamUrl_Route53HealthCheck.name
  region = var.region
  tags = var.tags
}

