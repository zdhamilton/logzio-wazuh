resource "aws_vpc" "vpc" {
	cidr_block = "10.0.0.0/16"
	enable_dns_hostnames = true
	tags = {
		Name = "${local.initials}_tf_vpc"
	}
}
resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.vpc.id}"
	tags = {
		Name = "${local.initials}_tf_intgateway"
	}
}
resource "aws_route_table" "rt" {
	vpc_id = "${aws_vpc.vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.igw.id}"
	}
	tags = {
		Name = "${local.initials}_tf_routetable"
	}
}
resource "aws_main_route_table_association" "rta" {
	vpc_id = "${aws_vpc.vpc.id}"
	route_table_id = "${aws_route_table.rt.id}"
}
resource "aws_subnet" "sub" {
	vpc_id = "${aws_vpc.vpc.id}"
	cidr_block = "10.0.0.0/24"
	tags = {
		Name = "${local.initials}_tf_subnet"
	}
}
resource "aws_security_group" "secgrp" {
	vpc_id = "${aws_vpc.vpc.id}"
	ingress {
		from_port = 0
		to_port = 22
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 0
		to_port = 80
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 0
		to_port = 443
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 0
		to_port = 1515
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "${local.initials}_tf_secgroup"
	}
}
