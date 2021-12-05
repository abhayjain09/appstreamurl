output "user_pool_client" {
  value = {
    ClientSecret  = "${module.cognito.user_pool_client.client_secret}"
    ClientId      = "${module.cognito.user_pool_client.client_id}"
    userpool_name = "${module.cognito.user_pool_client.userpool_name}"
    region        = var.region
    Environment   = var.environment
    api_gateway   = "${module.apigateway_AppstreamUrlAutomation.gateway_id.id}"
  }
  sensitive = true
}
