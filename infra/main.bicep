@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param name string

@minLength(1)
@maxLength(64)
@description('Azure OpenAI API Key')
param openaiApiKey string

@minLength(1)
@maxLength(64)
@description('Azure OpenAI Instance Name e.g. my-openai-instance')
param openaiInstanceName string

@minLength(1)
@maxLength(64)
@description('Azure OpenAI Deployment Name e.g. gpt3-turbo')
param openaiDeploymentName string

@minLength(1)
@maxLength(64)
@description('Azure OpenAI API Version e.g. 2021-08-04-preview')
param openaiApiVersion string

param authGithubId string
@secure()
param authGithubSecret string
param azureAdClientId string
@secure()
param azureAdClientSecret string
param azureAdTenantId string

var resourceToken = toLower(uniqueString(subscription().id, name, resourceGroup().location))


module resources 'resources.bicep' = {
  name: 'resources-${resourceToken}'
  params: {
    name: name
    resourceToken: resourceToken
    openai_api_key: openaiApiKey
    openai_instance_name: openaiInstanceName
    openai_deployment_name: openaiDeploymentName
    openai_api_version: openaiApiVersion
    auth_github_id: authGithubId
    auth_github_secret: authGithubSecret
    azure_ad_client_id: azureAdClientId
    azure_ad_client_secret: azureAdClientSecret
    azure_ad_tenant_id: azureAdTenantId
  }
}
