# ecs security group
resource "aws_security_group" "ecs-securitygroup" {
  vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
  name = "ecs"
  description = "security group for ecs"

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # allow port 8010 only from the eureka-server elb
  ingress {
      from_port = 8010
      to_port = 8010
      protocol = "tcp"
      security_groups = ["${aws_security_group.eureka-server-elb-securitygroup.id}"]
  } 

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  tags {
    Name = "ecs"
  }
}

# elb security group
resource "aws_security_group" "eureka-server-elb-securitygroup" {
  vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
  name = "eureka-server-elb"
  description = "security group for elb"

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
      cidr_blocks = ["0.0.0.0/0"]
  } 

  tags {
    Name = "eureka-server-elb"
  }
}
