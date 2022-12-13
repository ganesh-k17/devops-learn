# Terraform

* Open source provisioning template based tool
* It allows to create, edit, delete resource in seconds with the template created.
* Supports multiple platform (AWS, GCP, Azure, VMWare, etc).
* Providers helps terraform to connect with 3rd party API
* Terraform uses the language HCL (Harshicorp configuration language.). It is a simple declarative language, easy to read and write.
* This is declarative and can be managed in version control

## Three phases:

* Init
* Plan
* Apply

## Features

* Uses HCL - Delarative language
* ex:

    ```tf
    resource "aws_instance" "webserver" {
        ami = "ami-Oc2f25c1f66a1ff4d"
        instance_type = "t2.micro"
    }
    ```

* Resource:
    - It could be a file on a local host or it could be  a service in AWS/Azure/Google or other supported platforms.

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

* Init
* Plan
* Apply

![terraform-resource](images/terraform_init.jpg "terraform-resource")

![terraform-resource](images/terraform_plan.jpg "terraform-resource")

![terraform-resource](images/terraform_apply.jpg "terraform-resource")
