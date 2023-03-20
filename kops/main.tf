provider "aws" {
  region = var.region
}

resource "aws_iam_access_key" "kops" {
  user = aws_iam_user.kops.id
}

resource "aws_iam_user" "kops" {
  name = "kops"
  path = "/"
}

resource "aws_iam_user_policy" "kops_access" {
  name = "kops_access"
  user = aws_iam_user.kops.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:*",
          "route53:*",
          "s3:*",
          "iam:*",
          "vpc:*",
          "sqs:*",
          "events:*",
          "autoscaling:*",
          "elasticloadbalancing:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_route53_zone" "example_com" {
  name = "steveric.me"
}

resource "aws_route53_zone" "k8s_example_com" {
  name = "k8s.steveric.me"
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.example_com.zone_id
  name    = "k8s.steveric.me"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.k8s_example_com.name_servers
}

resource "aws_s3_bucket" "kops_state" {
  bucket = "${random_pet.bucket_name.id}-kops-state"
}

resource "random_pet" "bucket_name" {}