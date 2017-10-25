output "role_arn" {
  value       = "${aws_iam_role.dd_integration_role.arn}"
  description = "ARN for the Datadog integration role"
}
