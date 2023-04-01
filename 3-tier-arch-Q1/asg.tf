# Creating the autoscaling launch configuration that contains AWS EC2 instance details
resource "aws_launch_configuration" "aws_autoscale_conf" {
  name          = "web_config"
  image_id      = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = "sudhakar"
  lifecycle {
    create_before_destroy = true
  }
  user_data       = <<-EOF
#!/bin/bash
apt update -y
apt install apache2
EOF

}

resource "aws_autoscaling_group" "mygroup" {
  availability_zones        = ["us-east-1a"]
  name                      = "autoscalegroup"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type    = "ELB"
  load_balancers = ["${aws_elb.external-elb.id}"
  ]
  force_delete              = true
  termination_policies      = ["OldestInstance"]
  launch_configuration      = aws_launch_configuration.aws_autoscale_conf.name
  lifecycle {
    ignore_changes = [desired_capacity, target_group_arns]
  }
}

resource "aws_autoscaling_policy" "mygroup_policy" {
  name                   = "autoscalegroup_policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.mygroup.name
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "70"
  alarm_actions = [
    "${aws_autoscaling_policy.mygroup_policy.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.mygroup.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "30"
  alarm_actions = ["${aws_autoscaling_policy.mygroup_policy.arn}"]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.mygroup.name}"
  }
}