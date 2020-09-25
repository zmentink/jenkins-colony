provider "aws" {
  region = "${var.AWS_REGION}"
}

resource "aws_s3_bucket" "colony_bucket" {
  # bucket = "colony-bucket-${var.SANDBOX_ID}"
  bucket = "${BUCKET_NAME}"
  acl    = "private"
  versioning {
    enabled = true
  }
}


# # Policies

# resource "aws_iam_role_policy" "ec2_policy" {
#   name   = "ec2_policy"
#   role   = "${aws_iam_role.jenkins_ec2_role.id}"
#   policy = data.aws_iam_policy_document.s3-role-policy.json
# }

# resource "aws_iam_role" "jenkins_ec2_role" {
#   name               = "jenkins_ec2_role"
#   assume_role_policy = data.aws_iam_policy_document.ec2-assume-policy.json
# }


# # Instance Profile

# resource "aws_iam_instance_profile" "jenkins_ec2_profile" {
#   name = "colony-jenkins-profile-${var.SANDBOX_ID}"
#   role = "${aws_iam_role.jenkins_ec2_role.name}"
# }


# # Policies Documents

# data "aws_iam_policy_document" "s3-role-policy" {

#   statement {
#     actions   = ["s3:ListBucket"]
#     resources = ["arn:aws:s3:::colony-bucket-${var.SANDBOX_ID}"]
#     effect    = "Allow"
#   }

#   statement {
#     actions = [
#       "s3:ListAllMyBuckets",
#       "s3:HeadBucket"
#     ]
#     resources = ["*"]
#     effect    = "Allow"
#   }

#   statement {
#     actions = ["s3:*"]
#     resources = [
#       "arn:aws:s3:::colony-bucket-${var.SANDBOX_ID}/*",
#       "arn:aws:s3:::colony-bucket-${var.SANDBOX_ID}"
#     ]
#     effect = "Allow"
#   }
# }

# data "aws_iam_policy_document" "ec2-assume-policy" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#     effect = "Allow"
#   }
# }

# # Outputs
# output "jenkins_profile" {
#   value = "${aws_iam_instance_profile.jenkins_ec2_profile.name}"
# }

# output "bucket_name" {
#   value = "${aws_s3_bucket.colony_bucket.bucket}"
# }
