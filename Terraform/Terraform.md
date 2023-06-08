# Terraform

- Open source provisioning template based tool
- It allows to create, edit, delete resource in seconds with the template created.
- Supports multiple platform (AWS, GCP, Azure, VMWare, etc).
- Providers helps terraform to connect with 3rd party API
- Terraform uses the language HCL (Harshicorp configuration language.). It is a simple declarative language, easy to read and write.
- This is declarative and can be managed in version control

## Three phases:

- Init
- Plan
- Apply

## Features

- Uses HCL - Delarative language
- ex:

  ```tf
  resource "aws_instance" "webserver" {
      ami = "ami-Oc2f25c1f66a1ff4d"
      instance_type = "t2.micro"
  }
  ```

- Resource:
  - It could be a file on a local host or it could be a service in AWS/Azure/Google or other supported platforms.

## HCL

Syntax:

```hcl
<block> <parameters>{
    key1 = value1
    key2 = value2
}
```

![terraform-resource](images/hcl-resources.jpg "terraform-resource")

![terraform-resource](images/resStructure.jpg "terraform-resource")

## Steps

- Init
- Plan
- Apply

![terraform-resource](images/terraform_init.jpg "terraform-resource")

![terraform-resource](images/terraform_plan.jpg "terraform-resource")

![terraform-resource](images/terraform_apply.jpg "terraform-resource")

## Terraform Commands

```bash
terraform validate   # validate terraform configuration files
terraform fmt    # format the terraform configuration files
terraform show   # show terraform configurations
terraform show -json  # show terraform configurations as json
terraform providers  # show terrform providers used in state/config files
terraform providers mirror /root/terraform/new_local_file # copy terrafrom providers used in state/config files to another file
terraform output # show terraform output variables with value
terraform output <output-parameter-name> # show certain output variable value
terraform refresh  # sync the resources with terraform state file (I would refresh the state file if any manual updates happen in the realtime resources)
terraform plan # Show what are the changes to be done
terraform apply # Process config file and create the resources.  It would create the state file as well for the first time and update the statefile by calling refresh command.  But the refresh can be disabled by below command
terraform plan -refresh=<false/true> # refresh is disabled for plan
terraform apply -refresh=<false/true> # refresh is disabled for apply
terraform graph # show the graph by the statefile and show the dependency graph
terraform graph | dot -Tsvg > graph.svg   # graphviz should be installed.  Show the dependency graph as svg file.
```
