
########### Security Group for Web server ################################
resource "aws_security_group" "allow_all" {
  name = "allow_all"
  description = "Allow all inbound trafiic"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

########### Security Group for app server ################################
resource "aws_security_group" "app_security_group" {
  name = "app server sg"
  description = "Rules for allowing traffic"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/12"]
  }

  tags =  local.tags
}