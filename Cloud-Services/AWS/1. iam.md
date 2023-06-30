# IAM (Identity and Access Management)

- It is a global service.
- Root account created by default, shouldn't be used or shared.
- Users are people within your organization, and can be grouped.
- Groups only contain users, not other groups.
- Users don't have to belong to a group, and user can belong to multiple groups.

## IAM: Permissions

- Users or Groups can be assigned JSON documents called policies.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
```

- These policies define the permissions of the users
- In AWS you apply the least privilege principle: don't give more permissions than a user needs

## IAM Policies

1. Consists of
   - Version: policy language version, always include "2012-10-17"
   - Id: an identifier for the policy (optional)
   - Statement: one or more individual statements (required)
2. Statement consists of,
   - Sid: an identifier for the statement (optional)
   - Effect: whether the statement allows or denies access (Allow, Deny)
   - Principal: account/user/role to which this policy applied to
   - Action: list of actions this policy allows or denies.
   - Resource: list of resources to which the actions applied to
   - Condition: conditions for when this policy is in effect (optional)

## IAM Security Tools

- IAM Credentials Report (Account-Level)
  - A Report that lists all your account's users and the status of their various credentials
- IAM Access Adviser (User-level)
  - Access advisor shows the service permissions granted to a user and when those services were last accessed.
  - You can use this information to revise your policies.
