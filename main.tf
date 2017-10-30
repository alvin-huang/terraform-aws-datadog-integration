# Datadog Integration Policy Document #
data "aws_iam_policy_document" "dd_integration_policy_data" {
  statement {
    actions = [
      "autoscaling:Describe*",
      "budgets:ViewBudget",
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetTrailStatus",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "codedeploy:List*",
      "codedeploy:BatchGet*",
      "dynamodb:List*",
      "dynamodb:Describe*",
      "ec2:Describe*",
      "ec2:Get*",
      "ecs:Describe*",
      "ecs:List*",
      "elasticache:Describe*",
      "elasticache:List*",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeTags",
      "elasticloadbalancing:Describe*",
      "elasticmapreduce:List*",
      "elasticmapreduce:Describe*",
      "es:ListTags",
      "es:ListDomainNames",
      "es:DescribeElasticsearchDomains",
      "kinesis:List*",
      "kinesis:Describe*",
      "lambda:List*",
      "logs:Get*",
      "logs:Describe*",
      "logs:FilterLogEvents",
      "logs:TestMetricFilter",
      "rds:Describe*",
      "rds:List*",
      "route53:List*",
      "s3:GetBucketTagging",
      "s3:ListAllMyBuckets",
      "ses:Get*",
      "sns:List*",
      "sns:Publish",
      "sqs:ListQueues",
      "support:*",
      "tag:getResources",
      "tag:getTagKeys",
      "tag:getTagValues",
    ]

    resources = [
      "*",
    ]
  }
}

# Grant Datadog read access to AWS account #
data "aws_iam_policy_document" "manage_dd_integration_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::464622532012:root"]
    }

    condition = {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["${var.external_id}"]
    }
  }
}

# Datadog Integration Policy #
resource "aws_iam_policy" "dd_integration_policy" {
  name        = "DatadogAWSIntegrationPolicy"
  path        = "/"
  description = "Policy for Datadog integration"
  policy      = "${data.aws_iam_policy_document.dd_integration_policy_data.json}"
}

# Datadog Integration Role #
resource "aws_iam_role" "dd_integration_role" {
  name               = "DatadogAWSIntegrationRole"
  assume_role_policy = "${data.aws_iam_policy_document.manage_dd_integration_assume_role.json}"
}

# Attach Datadog Policy to Role #
resource "aws_iam_role_policy_attachment" "attach_dd_policy" {
  role       = "${aws_iam_role.dd_integration_role.name}"
  policy_arn = "${aws_iam_policy.dd_integration_policy.arn}"
}
