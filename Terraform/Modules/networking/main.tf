# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
      Name = "${upper(var.env)}-TF"
      env = "${var.env}"
      managed = "Terraform"
  }
}

# Default Public Subnet
resource "aws_subnet" "default_public" {
  count = "${length(split(",",var.azs))}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, 50+count.index)}"
  availability_zone = "${element(split(",",var.azs), count.index)}"
  tags {
      Name = "${upper(var.env)}-DEFAULT-${element(split(",",upper(var.azs_short)), count.index)}-PUBLIC"
      env = "${var.env}"
      managed = "Terraform"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
      Name = "${upper(var.env)}-IGW"
      env = "${var.env}"
      managed = "Terraform"
  }
}

# Default Public Routing Tables
resource "aws_route_table" "default_public" {
  vpc_id = "${aws_vpc.vpc.id}"
  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
      Name = "${upper(var.env)}-DEFAULT-PUBLIC"
      managed = "Terraform"
      env = "${var.env}"
  }
}

# Populate Default Public Routing Table
resource "aws_route" "default_public-gw" {
  route_table_id = "${aws_route_table.default_public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

# Associate Default subnets with this routing table
resource "aws_route_table_association" "default_public" {
  count = "${length(split(",",var.azs))}"
  subnet_id = "${element(aws_subnet.default_public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.default_public.*.id, count.index)}"
}

# Create SSH Security Groups
resource "aws_security_group" "ssh" {
  vpc_id = "${aws_vpc.vpc.id}"
  name = "${upper(var.env)}-SSH"
  description = "SSH Security group"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${upper(var.env)}-SSH"
    env = "${var.env}"
    managed = "Terraform"
  }
}
