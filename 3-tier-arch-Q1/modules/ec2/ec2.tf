resource "aws_instance" "web-1" {
  ami = var.imagename
  availability_zone = "us-east-1a"
  instance_type = var.instance_type
  key_name = "sudhakar-keypair"
  subnet_id = var.subnet1
  vpc_security_group_ids = ["${var.sg}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpcname}-Server-1"
  }
  iam_instance_profile = "${var.iam_instance_profile}"
}