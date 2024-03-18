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
