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

```tf
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

```tf
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
