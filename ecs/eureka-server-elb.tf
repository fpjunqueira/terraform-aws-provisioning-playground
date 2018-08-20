# elastic load balancer
resource "aws_elb" "eureka-server-elb" {
  name = "eureka-server-elb"

  listener {
    instance_port = 8010
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 30
    target = "HTTP:8010/"
    interval = 60
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  subnets = ["${aws_subnet.subnet-public-1.id}","${aws_subnet.subnet-public-2.id}"]
  security_groups = ["${aws_security_group.eureka-server-elb-securitygroup.id}"]

  tags {
    Name = "eureka-server-elb"
  }
}