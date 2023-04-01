resource "aws_cloudwatch_metric_alarm" "invalid_actions" {
  alarm_name                = "A test alarm for some actions"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  threshold                 = "25"
  alarm_description         = "This metric monitors messages received with invalid actions"
  insufficient_data_actions = []
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.notification_topic.arn]
  tags = local.tags
}


resource "aws_cloudwatch_metric_alarm" "cpuutilization" {
  alarm_name                = "Alaram to get notification on cpu utilization of ec2"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.notification_topic.arn]
  tags = local.tags
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_too_high" {
  alarm_name          = "Average database CPU utilization is too high."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 3600
  statistic           = "Maximum"
  threshold           = 50
  alarm_description   = "This alert is for database CPUUtilization"
  alarm_actions       = [aws_sns_topic.notification_topic.arn]
  ok_actions          = []

  dimensions = {
    DBInstanceIdentifier = "postgresql-${var.environment}"
  }
  tags = local.tags
}