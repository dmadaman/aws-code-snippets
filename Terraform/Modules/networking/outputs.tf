output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "default_public_subnets" {
  value = "${join(",",aws_subnet.default_public.*.id)}"
}
output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}
output "sg_ssh" {
  value = "${aws_security_group.ssh.id}"
}
