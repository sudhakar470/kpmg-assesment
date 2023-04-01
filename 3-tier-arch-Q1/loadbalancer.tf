resource "aws_lb" "external-elb" {
  count = var.environment == "dev" || var.environment == "uat" || var.environment == "prod" ? 1 : 0
  name               = "External-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = [aws_subnet.subnet1-public.id, aws_subnet.subnet2-public.id]
  idle_timeout = 300
}
resource "aws_lb_listener" "external_lb_listener" {
  count = var.environment == "dev" || var.environment == "uat" || var.environment == "prod" ? 1 : 0
  load_balancer_arn = aws_lb.external-elb[count.index].arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.sudhakar_certificate.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.external_alb_tg.arn
  }
}

resource "aws_lb_target_group" "external_alb_tg" {
  name        = "sudhakar-app1"
  target_type = "ip"
  port        = "443"
  protocol    = "HTTPS"
  vpc_id      = "${aws_vpc.default.id}"

  tags = local.tags
}

resource "aws_autoscaling_attachment" "external_alb_attach" {
  autoscaling_group_name = aws_autoscaling_group.mygroup.id
  alb_target_group_arn   = aws_lb_target_group.external_alb_tg.arn
}