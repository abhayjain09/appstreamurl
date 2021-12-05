## Requirements

The following requirements are needed by this module:

- terraform (~> 0.13.0)

- aws (~> 3.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

## Required Inputs

The following input variables are required:

### identifiers

Description: List of service identifiers allowed to assume role.

Type: `list(string)`

## Optional Inputs

The following input variables are optional (have default values):

### type

Description: The type of principal.  Either AWS or Service

Type: `string`

Default: `"AWS"`

## Outputs

The following outputs are exported:

### policy

Description: Returns an assume role policy document that grants an IAM Role or AWS Service perms to assume a role.

