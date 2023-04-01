resource "aws_route_table" "terraform-public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags = {
    Name = "${var.public_routing_table}"
  }

}

resource "aws_route_table_association" "terraform-public1" {
  subnet_id = "${aws_subnet.subnet1-public.id}"
  route_table_id = "${aws_route_table.terraform-public.id}"
}

resource "aws_route_table_association" "terraform-public2" {
  subnet_id = "${aws_subnet.subnet2-public.id}"
  route_table_id = "${aws_route_table.terraform-public.id}"
}


resource "aws_route_table" "terraform-private" {
  vpc_id = "${aws_vpc.default.id}"

  tags = {
    Name = "${var.private_routing_table}"
  }

}

resource "aws_route_table_association" "terraform-private1" {
  subnet_id = "${aws_subnet.subnet1-private.id}"
  route_table_id = "${aws_route_table.terraform-private.id}"
}

resource "aws_route_table_association" "terraform-private2" {
  subnet_id = "${aws_subnet.subnet2-private.id}"
  route_table_id = "${aws_route_table.terraform-private.id}"
}
