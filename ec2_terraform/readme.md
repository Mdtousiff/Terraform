## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_linux_instance"></a> [ec2\_linux\_instance](#module\_ec2\_linux\_instance) | ./modules | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | ami of instances to be deployed | `string` | `"ami-0f0c9a552f9ec134a"` | no |
| <a name="input_application"></a> [application](#input\_application) | Name of the application | `string` | `"aws_ec2_linux_instance"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment | `string` | `"test"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the EC2 instance deployed. | `string` | `"vm-test"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t2.micro"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Name of the owner | `string` | `"infra@insight.com"` | no |
| <a name="input_region"></a> [region](#input\_region) | Name of the Region | `string` | `"us-east-1"` | no |
| <a name="input_service"></a> [service](#input\_service) | Name of the service | `string` | `"Infrastructure layer"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | `"VPC-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ec2_linux"></a> [aws\_ec2\_linux](#output\_aws\_ec2\_linux) | application |
