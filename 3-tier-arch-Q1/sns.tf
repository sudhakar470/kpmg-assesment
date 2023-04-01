resource "aws_sns_topic" "notification_topic" {
  name = "notification-alerts"
  tags = local.tags
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.notification_topic.arn
  protocol  = "email"
  endpoint  = "abc@xyz.com"
}