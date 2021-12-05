## Requirements

The following requirements are needed by this module:

- terraform (~> 0.13.0)

- aws (~> 3.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

## Required Inputs

The following input variables are required:

### name

Description: The name of the IAM role to create.

Type: `string`

### service

Description: The name of service allowed to assume role ie lambda or ec2.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### policy\_arns

Description: List of default IAM policy ARNs for role.

Type: `list(string)`

Default: `[]`

### policy\_documents

Description: List of IAM Policy Documents for the role.

Type: `list(string)`

Default: `[]`

### tags

Description: Additional tags associated with the role.

Type: `map(string)`

Default: `{}`

### assume\_role\_policy\_document

Description: (Optional) List of IAM Policy Documents allowed to assume the role. Takes a json encoded string

Type: `string`

Default: `null`

### description

Description: Description of the IAM role.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### arn

Description: The Amazon Resource Name (ARN) specifying the role.

### id

Description: The name of the role.

### max\_session\_duration

Description: The maximum session duration (in seconds).

### unique\_id

Description: The stable and unique string identifying the role.

