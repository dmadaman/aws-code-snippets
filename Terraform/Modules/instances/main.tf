resource "aws_instance" "instance" {
    count = "${var.count}"
    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    subnet_id = "${element(split(",",var.subnets), count.index % length(split(",",var.subnets)))}"
    vpc_security_group_ids = ["${split(",",var.sgs)}"]
    root_block_device {
        volume_size = "30"
    }
    tags {
        Name = "${var.env}.${var.tag_name}${ceil(count.index / length(split(",", var.subnets))) + 1}${lower(element(split(",",var.azs_short), count.index % length(split(",",var.subnets))))}"
    }
}

resource "aws_eip" "eip" {
  count = "${var.count}"
  instance = "${element(aws_instance.instance.*.id, count.index)}"
  vpc = true
}
