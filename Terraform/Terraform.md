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

## Meta Arguments:

- depends_on:

```t
resource "local_file" "pet" {
    filename = var.filename
    content = var.content
    depends_on = [
        random_pet.my-pet
    ]
}

resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
```

- lifecycle:

```t
resource "local_file" "pet" {
    filename = "/root/pets.txt"
    content = "We love pets!"
    file_permission = 0700
    lifecycle {
        create_before_destroy = true
    }
}
```

- Count

```t
resource "local_file" "pet" {
    filename = var.filename[count.index]
    count = 3  # Explicitly mentioned count value as 3
}
variable "filename" {
    default = [
        "/root/pets.txt",
        "/root/dogs.txt",
        "/root/cats.txt"
    ]
}
```

```t
resource "local_file" "pet" {
    filename = var.filename[count.index]
    count = length(var.filename)  # it would pick the length from the filename variable and assigned to count
}
variable "filename" {
    default = [
        "/root/pets.txt",
        "/root/dogs.txt",
        "/root/cats.txt"
        "/root/deer.txt"
        "/root/peacock.txt"
    ]
}
```

- for-each

```t
resource "local_file" "pet" {
    filename = each.value
    for-each =var.filename  # it would pick the length from the filename variable and assigned to count
}
variable "filename" {
    type = set(string)
    default = [
        "/root/pets.txt",
        "/root/dogs.txt",
        "/root/cats.txt"
    ]
}
```

for-each only support only map or set. so if the filename is list type we have to convert it to set by using `toset()` method,

```t
resource "local_file" "pet" {
    filename = each.value
    for-each = toset(var.filename)  # it would pick the length from the filename variable and assigned to count
}
variable "filename" {
    type = list(string)
    default = [
        "/root/pets.txt",
        "/root/dogs.txt",
        "/root/cats.txt"
    ]
}
```

Version Constraints:

```t
terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "1.4.0"
            # version = "!= 2.0.0"
            # version = "> 1.1.0"
            # version = "> 1.2.0, < 2.0.0, != 1.4.0"
            # version = "~> 1.2"
            # version = "~> 1.2.0"
        }
    }
}

resource "local_file" "pet" {
    filename = "/root/pet.txt"
    content = "We love pets!"
}
```

## Setting variable or input to variables

- By ignore default values (have empty variables.)

  ```t
  variable "filename" {

  }

  variable "content" {

  }
  ```

  when we have defined empty variables as above, The variables will be prompted while calling Terraform apply.

- By exporting variable,

  ```bash
  > export TF_VAR_filename="/root/pets.txt"
  > export TF_VAR_content="We love pets"
  ```

- While passing variables in terraform apply

  ```bash
  > terraform apply -var "filename=/root/pets.txt" -var "content=We love Pets"
  ```

- By using .tfvars file.

  ```s
  # We can create a .tfvars file and define the variables in the file.

  filename="/root/pets.txt"
  content="We love pets!"

  # here, if we have the filename as terraform.tfvars, terraform.tfvars.json, *.auto.tfvars, *.auto.tfvars.json then terraform automatically pick these files for setting variables values.

  # But if we have any other names for file name we need to mention it in `terraform apply` command, ex: variables.tfvars

  > terraform apply -var-file variables.tfvars
  ```

- Precedence based on highest priority,

  ```txt
  -var or -var-file (command line flags)
  *.auto.tfvars (alphabetical order)
  terraform.tfvars
  Environment variables
  ```

## Make use of one resource to another resource by using reference expression

```t
resource "local file" "pet" {
    filename = var.filename
    content = "My favorite pet is ${random_pet.my-pet.id}"   # we have used random_pet resource id property to geneate content
}
resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}

# In the above scenario, The local file is depend on random_pet resource by using reference expression.  So when the resources are get deleted, terraform would delete the local file first and delete the random_pet next.  In the same way when resources are gets created, random_pet first gets created and the local_file created next.  This is called implicit dependency as we haven't mention the dependency explicitly but with reference expression.
```

## Explicit Dependency using depends_on attribute

```t
resource "local file" "pet" {
    filename = var.filename
    content = "My favorite pet is cat"
    depends_on = [
        random_pet.my-pet
    ]
}
resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
```

## output variable

```t
resource "local file" "pet" {
    filename = var.filename
    content = "My favorite pet is ${random_pet.my-pet.id}"   # we have used random_pet resource id property to geneate content
}
resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
output pet-name {
    value = random_pet.my-pet.id
    description = "Record the value of pet Id generated by the random_pet resource"
}

# we can use output type to define output variables.  this can be used to quickly use the resource attirbutes of a resource.
# we can use `terraform output` command to display all the output variables in the current congiruation directory.
# we can use `terraform output pet-name` to display particualt output variable value.
```

## Life-cycle rules

```t
resource "local_file" "pet" {
    filename = "/root/pets.txt"
    content = "We love pets!"
    file_permission = "0700"

    lifecycle {
        prevent_destroy = true
    }
}

# other life-cycle rules

# create_before_destroy -> Create the resource first and then destroy older
# prevent_destroy -> Prevents destroy of a resource
# ignore_changes  -> Ignore Changes to Resource Attributes (specific/all)
```

## Datasource

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions or other approaches.

Data attribute have similar syntax of resource!

```t
resource "local_file" "pet" {
    filename = "/root/pets.txt"
    content = data.local_file.dog.content   # we have to use data object to use dog datasource content
}

data "local_file" "dog" {
    filename = "/root/pets.txt"
}
```

Difference between Resource and Data source:

| Resource                                      | Data Source                    |
| --------------------------------------------- | ------------------------------ |
| Keyword : **resource**                        | Keyword: **data**              |
| **Creates, Updates, Destroys** Infrastructure | Only **Reads** Infrastructure  |
| Also called **Managed Resources**             | Also called **Data Resources** |

## Remote state

- Remote Backends with S3 and Dynamo DB

Here S3 used to store Terraform and Dynamo DB is used to support state locking (and consistent check).

```t

resource "local_file" "pet" {
    filename = "/root/pets.txt"
    content = "we love pets."
}

terraform {
    backend "s3" {
        bucket = "ganesh-terraform-state-bucket01"
        key = "finance/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "state-locking"  # this table should have a primary or a hash key with the name lockID.
    }
}

```

- Terraform state commands

```shell
terraform state list [options] [address]

# aws_dynamodb_table.cars
# aws_s3_bucket.finance-2020922

terraform state list aws_s3_bucket.finance-2020922
# aws_s3_bucket.finance-2020922

terraform state show [options] [address]

terraform state show aws_s3_bucket.finance-2020922

terraform state mv [options] SOURCE DESTINATION  # Moving state file from one to another

terraform state mv "aws_dynamodb_table.state-locking" to "aws_dynamodb_table.state-locking-db"

terraform state pull | jq '.resources[] | select(.name == "state-locking-db")|.instances[].attributes.hash_key'

# LockID

terraform state rm <RESOURCE-ADDRESS>  # Remove an item from terraform state file

# Acquiring state lock.  This may take a few moments...
# Removed aws_s3_bucket.finance-2020922
# Successfully removed 1 resource instance(s)
# Releasing state lock.  This may take a few moments...
```

## Terraform `Taint`

When a resource marked as Taint, while running terraform plan it force the resource to be recreated instead of update.

```bash
terraform taint aws_instance.webserver
```

```bash
terraform untaint aws_instance.webserver
```

## Debugging

We can debug and investigate terraform execution by setting TF_LOG environment variable.

The options can be,

- INFO
- WARNING
- ERROR
- DEBUG
- TRACE

```bash
export TF_LOG=TRACE
```

We can use TF_LOG_PATH to save the terraform execution logs to a file.

```bash
export TF_LOG_PATH=/tmp/terraform.log
```

## Terraform Import

`terraform import` lets you target a resource that already exists, and map it to a resource you've defined in code and manage the resources by terraform. (But The datasources in terraform can be used to only access the data not manage the resource with terraform)

```bash
terraform import <resource_type>.<resource_name> <attribute>
```

```t
# When we run terraform import, we would get error as resource does not exist in the configuration.
# terraform import would not update terraform configuration. So to make it work we have to create a dummy resource in tf file as below

# main.tf

resource "aws_instance" "webserver-2" {
    # ( resource arguments )
}

# When we call the terraform import.  it would import the resource.
terraform import aws_instance.webserver-2 i-02342984792874982

# now the resource is imported in the terraform state file.
# then we can update the resource values in the terraform resource.
# These data can be get from aws console or we can get the data from terraform state file as it is already imported.


resource "aws_instance" "webserver-2" {
    ami = "ami-0edab43b6fa892279"
    instane_type = "t2.micro"
    key_name = "ws"
    vpc_security_group_ids = ["sg-8064fdee"]
}

# once all the arguments are added and while running `terraform plan`, it would refresh the state and it would get to know that resource already exist and does not have any change.  Going forward any changes to this resource can be carried out by terraform configuration file and follw the terraform workflow.
```

## Other Terraform functions

- file: `eg: file("/root/terraform-projects/main.tf")`
- length: `eg: length(var.filename)`
- toset: `eg: toset(var.regions)`

### Other Terraform function categories

- Numeric Functions
  - max(-1,2,-10,200,-250)
  - min(-1,2,-10,200, -250)
  - ceil(10.1)
  - floor(10.9)
- String Functions
  - split(",", "ami-xyz, AMI-ABC, ami-efg")
  - lower(var.ami)
  - upper(var.ami)
  - title(var.ami)
  - title(var.ami)
  - substr(var.ami, 0, 7)
  - join(",",["ami-xyz","AMI-ABC","ami-efg"])
- Collection Functions
  - length(var.ami)
  - index(var.ami, "AMI-ABC")
  - element(var.ami,2)
  - contains(var.ami, "AMI-ABC")
- Map Functions
  - keys(var.ami)
  - values(var.ami)
  - lookup(var.ami, "ca-central-1")
