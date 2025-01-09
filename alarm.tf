# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name                = "tschui_lambda_info_count_breach_alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "info-count"
  namespace                 = "/moviedb-api/tschui"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 10
  alarm_description         = "info-count > 10 for 1 datapoints within 1 minute"
  actions_enabled           = true

  # Add SNS topic for notification (uncomment and adjust below)
  alarm_actions = [aws_sns_topic.lambda_error_alarm_topic.arn]
}

# SNS Topic for Alarm Notifications
resource "aws_sns_topic" "lambda_error_alarm_topic" {
  name = "tschui_lambda_info_count_breach_alarm_topic"
}

# SNS Subscription
resource "aws_sns_topic_subscription" "lambda_error_alarm_subscription" {
  endpoint = "tschui@gmail.com"
  protocol = "email"
  topic_arn = aws_sns_topic.lambda_error_alarm_topic.arn
}
