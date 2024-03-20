# Terraform & AWS

## IAM Policies with Terraform

```t

# without any access policy or permission

resource "aws_iam_user" "user" {
    name = "lucy"
    tags = {
        Description = "Technical Team Lead"
    }
}
```

```t
#  with admin access fot the user

resource "aws_iam_user" "admin-user" {
    name = "lucy"
    tags = {
        Description = "Technical Team Lead"
    }
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers"
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
            }
        ]
    }
    EOF
}

resource "aws_iam_user_policy_attachment" "lucy-admin-access" {
    user = aws_iam_user.admin-user.name
    policy_arn = aws_iam_policy.adminUser.arn
}
```

```t
# Using policy file

resource "aws_iam_user" "admin-user" {
    name = "lucy"
    tags = {
        Description = "Technical Team Lead"
    }
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers"
    policy = file("admin_policy.json")
}

# admin_policy.json file content
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}

resource "aws_iam_user_policy_attachment" "lucy-admin-access" {
    user = aws_iam_user.admin-user.name
    policy_arn = aws_iam_policy.adminUser.arn
}
```

## S3 with terraform

```t
resource "aws_s3_bucket" "finance" {
    bucket = "finance-21092020"
    tags = {
        Description = "Finance and payroll"
    }
}

resource "aws_s3_bucket_object" "finance-2020"{   # aws_s3_bucket_object depricated, we have to use aws_s3_object instead
    content = "/root/finance/finance-2020.doc"
    key = "finance-2020.doc"
    bucket = aws_s3_bucket.finance.id
}

data "aws_iam_group" "finance-data" {
    group_name = "finance-analysts"
}

resource "aws_s3_bucket_policy" "finance-policy" {
    bucket = aws_s3_bucket.finance.id
    policy = <<EOF
        {
            "version" : "2012-10-17",
            "Statement": [
                {
                    "Action": "*",
                    "Effect": "Allow",
                    "Resource": "arn:aws:s3:::${aws_s3_bucket.finance.id}/*",
                    "Principal": {
                        "AWS": [
                            "${data.aws_iam_group.finance-data.arn}"
                        ]
                    }
                }
            ]
        }
    EOF
}

```

```t
# to updload a file to an existing bucket

resource aws_s3_object "upload" {
    bucket = "pixer-studios-2020"
    key ="woody.jpg"
    source = "/root/woody.jpg"
}
```

## Dynamo DB with terraform

```t
resource "aws_dynamodb_table" "cars" {
    name = "cars"
    hash_key = "VIN"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
        name = "VIN"
        type = "S"
    }
}

resource "aws_dynamodb_table_item" "car-items" {
    table_name = aws_dynamodb_table.cars.name
    hash_key = aws_dyamodb_table.cars.hash_key
    item = <<EOF
    {
        "Manufacturer" : {"S":"Toyota"},
        "Make": {"S": "Corolla"},
        "Year": {"N": "2004"}
        "VIN": {"S": "4Y1SL6584Z411439"}
    }
    EOF
}
```

## EC2 with Terraform

```t
provider "aws" {
    region = "us-west-1"
}

resource "aws_security_group" "ssh-access" {
    name = "ssh-access"
    description = "Allow SSH access from the internet"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "webserver" {
    ami = "ami-oedab43b6fa892279"
    instance_type = "t2.micro"
    tags = {
        Name = "webserver"
        Description = "An Nginx Webserver on Ubuntu"
    }
    key_name = aws_key_pair.web.id
    vpc_security_group_ids = [ aws_security_group.ssh-access.id ]
    user_data = <<EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    systemctl enable nginx
    systemctl start nginx
    EOF
}

resource "aws_key_pair" "web" {
    public_key = file("/root/.ssh/web.pub")
}

output publicip {
    value = aws_instance.webserver.public_ip
}
```

Terraform Provisioners:

It is like user data. They are commands to run in the created instances.

Remote Exec:

These commands in the inline list will be run on the remote instance once the resource created.
It is not garuanteed that the commands run, since it may require internet connectivity. So we would have security group added for ssh to enable internet connectivity for the instance.

```t
resource "aws_instance" "webserver" {
    ami = "ami-08749374937498374983"
    instance_type = "t2.micro"
    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx"
        ]
    }
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file("/root/.ssh/web")
    }
    key_name = aws_key_pair.web.id
    vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_security_group" "ssh-access" {
    # code here
}

resource "aws_key_pair" "web" {
     # code here
}

resource "aws_eip" eip {  # create elastic ip for the instance and it runs local-exec script to print public dns
    vpc = true
    instance = aws_instance.cerberus.id
    provisioner "local-exec" {
      command = "echo ${aws_eip.eip.public_dns} >> /root/cerberus_public_dns.txt"
    }
}
```

Local Exec:

Local exec provisioner is used to run tasks on the local machine where we running
the Terraform binary and not on the resources we are creating using terraform.

```t
resource "aws_instance" "webserver" {
    ami = "ami-0edab43b6fa892279"
    instance_type = "t2.micro"
    provisioner "local-exec" {
        on_failure = fail   # we can use continue instead of fail to make the apply command success eventhough this local-exec provisioner fails (this on_failure is called Failure Behaviour Provisioner)
        command = "echo Instance ${aws_instance.webserver.public_ip} created! > /temp/instance_state.txt"
    }

    provisioner "local-exec" {
        when = destroy  # This is Destroy Time Provisioner (to guide when this command should be executed.  Here it is while destroy the resource.)
        command = "echo Instance ${aws_insance.webserver.public_ip destroyed > /tmp/instance_state.txt"
    }
}
```

Note: Whereever possible we need to make use of options natively available like Userdata instead of provisioners in AWS and Custom data for Azure, metadata for GCP, etc.
