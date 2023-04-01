data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Ubuntu Server 22.04*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "webserver" {
  ami_id = data.aws_ami.ami.id
  availability_zone = "us-east-1a"
  instance_type = "t2.micro"
  key_name = "sudhakar"
  subnet_id = "${aws_subnet.subnet1-public.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = local.tags
}

resource "aws_instance" "appserver" {
  ami_id = data.aws_ami.ami.id
  availability_zone = "us-east-1d"
  instance_type = "t2.micro"
  key_name = "sudhakar"
  subnet_id = "${aws_subnet.subnet1-private.id}"
  vpc_security_group_ids = ["${aws_security_group.app_security_group.id}"]
  associate_public_ip_address = false
  tags = local.tags

}