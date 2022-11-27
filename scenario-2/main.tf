locals {
  users = jsondecode(file("./users.json"))
}

# Create users
resource "aws_iam_user" "this" {
  for_each = {for u in local.users : u.name => u}
  name     = each.value.name
  tags     = {
    role   = each.value.role
    groups = join(":", each.value.groups)
  }
}

# Create groups
resource "aws_iam_group" "this" {
  for_each = toset(flatten([for u in local.users : u.groups]))
  name     = each.value
}

# Add policy (AmazonEC2FullAccess) to groups
resource "aws_iam_policy_attachment" "this" {
  name       = "ec2_full_access"
  groups     = toset(flatten([for u in local.users : u.groups]))
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Add users to groups
resource "aws_iam_user_group_membership" "this" {
  for_each = {for u in local.users : u.name => u}
  user     = each.value.name
  groups   = each.value.groups
}

# Create roles
resource "aws_iam_role" "this" {
  for_each           = toset([for u in local.users : u.role])
  name               = each.value
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Sid": "",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
}
EOF
}

# Add policy specific to roles
resource "aws_iam_role_policy" "s3-mybucket-role-policy" {
  for_each = toset([for u in local.users : u.role])
  name     = "${each.value}-role-policy"
  role     = aws_iam_role.this[each.value].id
  policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::mybucket-123",
              "arn:aws:s3:::mybucket-123/*"
            ]
        }
    ]
}
EOF
}
