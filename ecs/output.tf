# the point that we can access
output "elb" {
  value = "${aws_elb.eureka-server-elb.dns_name}"
}