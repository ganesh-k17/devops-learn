resource "aws_iam_user" "users" {
    count = length(var.project-sapphire-users)
    name =  var.project-sapphire-users[count.index]
    tags = {
        Description = "Users"
    }
}