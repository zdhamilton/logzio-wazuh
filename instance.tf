resource "aws_instance" "vm-wazuh-manager" {
	subnet_id = "${aws_subnet.sub.id}"
	vpc_security_group_ids = ["${aws_security_group.secgrp.id}"]
	ami = "ami-04b9e92b5572fa0d1"
	instance_type = "t2.micro"
	key_name = "zh_ssh_key"
	tags = {
		Name = "${local.initials}_tf_instance_wazuh_manager"
	}
}

resource "aws_instance" "vm-wazuh-agent" {
	subnet_id = "${aws_subnet.sub.id}"
	vpc_security_group_ids = ["${aws_security_group.secgrp.id}"]
	ami = "ami-04b9e92b5572fa0d1"
	instance_type = "t2.micro"
	key_name = "zh_ssh_key"
	tags = {
		Name = "${local.initials}_tf_instance_wazuh_agent"
	}
}

resource "aws_eip" "eip-wazuh-manager" {
	vpc = true
	instance = "${aws_instance.vm-wazuh-manager.id}"
	depends_on = ["aws_internet_gateway.igw"]
	tags = {
		Name = "${local.initials}_tf_eip_wazuh_manager"
	}
}

resource "aws_eip" "eip-wazuh-agent" {
	vpc = true
	instance = "${aws_instance.vm-wazuh-agent.id}"
	depends_on = ["aws_internet_gateway.igw"]
	tags = {
		Name = "${local.initials}_tf_eip_wazuh_agent"
	}
}