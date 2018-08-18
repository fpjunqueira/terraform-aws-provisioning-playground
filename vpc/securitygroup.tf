resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
  name = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.MYIP}"]
  } 
tags {
    Name = "allow-ssh"
  }
}

resource "aws_security_group" "allow-my-ip" {
  vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
  name = "allow-my-ip"
  description = "security group that allows my ip traffic"

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${var.MYIP}"]
  } 
tags {
    Name = "allow-my-ip"
  }
}