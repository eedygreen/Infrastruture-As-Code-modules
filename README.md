# Infrastruture-As-Code-modules

### Terraform Modules
These modules provisions the followings on Simulated Cloud environment (localstack);
- Cluster
- S3
- Ingress
- Deployement


## Requirements

-   Terraform
-   Docker
-   kind
-   Localstack
-   existing 

## Usage

To use this module, you can include it in your Terraform configuration as follow, the traditional way:

```hcl
module "infrastructure" {
  source = "git::https://github.com:eedygreen/Infrastruture-As-Code-modules/modules/cluster?ref=vref_numer"

  cluster_name    = "my-kind-cluster"
  config_filename = "path/to/your/config.json"
  cluster_version = "1.21.1"
  bucket_name     = "my-s3-bucket"
  object_name     = "my-object-key"
}
```

The API way, i.e if you are using Terragrunt use the `units` or `stacks` instead of `modules`. The API is more secure giving your users a an endpoint decoupled from the application core logic (the Modules).

Keep in mind, the API is structured to reduce the blast radius with the traditional (module) style.
```sh
source = git::https://github.com:eedygreen/Infrastruture-As-Code-modules/units/cluster?ref=vref_numer"
```
> **[INFO]** <br>
>The tag `vref_number` in reality it is semantic versioning which should looks like this corespondings `v0.1.0` or `v0.0.1` or `v2.0.0`. 

For more details on how to use the API version with Terragrunt, see [High-Availability-Infrastructure-with-Iac](https://github.com/eedygreen/High-Availability-Infrastructure-with-Iac.git)

## Features
These are decoupled services that can be use separately or together. 

-   **Kubernetes Cluster**: Deploys a local Kubernetes cluster using `kind`.
-   **AWS S3 Bucket**: provisions an S3 bucket in a cloud simulated `Localstack` environment.
- **Ingress**: Deploys an Nginx Ingress
- **App**: Deployment with service


## Inputs

| Name              | Description                                      | Type   | Default | Required |
| ----------------- | ------------------------------------------------ | ------ | ------- | :------: |
| `cluster_name`    | The name of the `kind` cluster.                  | `string` | `""`      |   yes    |
| `config_filename` | The path to the file to be uploaded to the S3 bucket. | `string` | `""`      |   yes    |
| `cluster_version` | The version of the `kind` cluster.               | `string` | `""`      |   yes    |
| `bucket_name`     | The name of the S3 bucket.                       | `string` | `""`      |   yes    |
| `object_name`     | The name of the object in the S3 bucket.        | `string` | `""`      |   yes    |


## Outputs

| Name               | Description                                  |
| ------------------ | -------------------------------------------- |
| `cluster_endpoint` | The endpoint of the `kind` cluster.          |
| `cluster_name`     | The name of the `kind` cluster.              |
| `bucket_name`      | The name of the S3 bucket.                   |
| `config_filename`  | The name of the file uploaded to the S3 bucket. |

## Destroy Behavior
When the S3 bucket is destroyed, all objects within the bucket are also deleted to prevent errors during the destruction process. This is controlled by the `force_destroy` variable, which is set to `true` by default. If you want to retain the objects in the bucket when destroying the infrastructure, you can set this variable to `false`.

```hcl
variable "force_destroy" {
  description = "Whether to force destroy the S3 bucket and all its objects."
  type        = bool
  default     = true
}
```
This will ensure that the S3 bucket and its contents are deleted when you run `make destroy`, preventing any potential errors related to non-empty buckets.


more to be added. 
You can checkout the usage