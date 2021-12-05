## Requirements

The following requirements are needed by this module:

- terraform (~> 0.13.0)

- aws (~> 3.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

## Required Inputs

The following input variables are required:

### function\_arn

Description: The ARN of the lambda function.

Type: `string`

### schedule\_expression

Description: The scheduling expression. For example, cron(0 20 \* \* ? \*) or rate(5 minutes)

Type: `string`

### schedule\_name

Description: The name of the schedule for the lambda.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### tags

Description: Tags associated with scheduled event lambda.

Type: `map(string)`

Default: `{}`

### input

Description: Valid JSON text passed to the target.

Type: `string`

Default: `null`

### schedule\_description

Description: Specifies event for which to send notifications.

Type: `string`

Default: `null`

## Outputs

No output.

