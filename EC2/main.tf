provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "master" {
  key_name = "master-key"
  public_key = "${file(var.master-key)}"
}
resource "aws_instance" "ec2_instance" {
  count = 2
  ami = "ami-0d5eff06f840b45e9"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${var.security_group}"]
  key_name = "${aws_key_pair.master.id}"
  subnet_id = "${element(var.subnets, count.index )}"
  user_data = "${data.template_file.init.rendered}"
  tags = {
    Name = "my-new-instance-${count.index + 1}"
  }
}

data "template_file" "init" {
  template = "${file("${path.module}/userdata.tpl")}"
}
