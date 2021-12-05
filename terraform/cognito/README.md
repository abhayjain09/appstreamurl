## Requirements

No requirements.

## Providers

The following providers are used by this module:

- aws

## Required Inputs

The following input variables are required:

### certificate\_arn

Description: The ARN of the Amazon Certificate Manager (ACM) certificate for the cognito domain.

Type: `string`

### domain

Description: The domain name used to host the cognito user experience in cloudfront. This will be prefixed with `auth.`

Type: `string`

### name

Description: The name of the cognito user and identity pool.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### enable\_anonymous\_access

Description: A value indicating whether or not to enable anonymous access within the identity pool.

Type: `bool`

Default: `false`

### oidc\_callback\_urls

Description: The callback URL that the IDP should redirect to after authentication.

Type: `list(string)`

Default: `[]`

### oidc\_scopes

Description: The list of scopes to request from the oidc issuer. DEFAULT: openid email profile

Type: `list(string)`

Default:

```json
[
  "openid",
  "email",
  "profile"
]
```

### tags

Description: Additional tags associated with the resource.

Type: `map(string)`

Default: `{}`

### oidc\_client\_id

Description: The client id assigned to the product / project by the IDP, such as SAM-IS.

Type: `string`

Default: `null`

### oidc\_client\_secret

Description: The client secret assigned to the product / project by the IDP, such as SAM-IS.

Type: `string`

Default: `null`

### oidc\_issuer

Description: The URL of the oidc issuer. DEFAULT: https://sam.ihsmarkit.com:443/sso/oauth2

Type: `string`

Default: `"https://sam.ihsmarkit.com:443/sso/oauth2"`

### oidc\_provider

Description: The name of the oidc provider. DEFAULT: SAM-IS

Type: `string`

Default: `"SAM-IS"`

## Outputs

The following outputs are exported:

### assume\_policy

Description: The policy to use to allow cognito authenticated users to assume other roles.

### authenticated\_policy

Description: The policy to use for authenticated users.

### distribution

Description: The details for the CloudFront distribution used to host the cognito UI.

### identity\_pool

Description: The identifier and arn of the cognito identity pool.

### oidc

Description: The name, issuer, and scopes of the oidc identity provider.

### user\_pool

Description: The identifier and arn of the cognito user pool.

