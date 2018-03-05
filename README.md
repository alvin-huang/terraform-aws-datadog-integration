[![Build Status](https://travis-ci.org/alvin-huang/terraform-aws-datadog-integration.svg?branch=master)](https://travis-ci.org/alvin-huang/terraform-aws-datadog-integration)

# terraform-aws-datadog-integration
Terraform Module to set up AWS Datadog Integration

This is a translation of the steps found at https://docs.datadoghq.com/integrations/aws/

Usage
-----
```hcl
module "datadog-integration" {
  source = "alvin-huang/datadog-integration/aws"
  external_id = "123456789012"
}
```
License
-----
Apache 2 Licensed. See [LICENSE](LICENSE)
