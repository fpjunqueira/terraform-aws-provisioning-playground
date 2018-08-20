# ECS 

# 1. crate a cluster
# 2. create a launch config with IMA, key, instance type, security group
# 3. config and start the ecs agent
# 4. create the auto scaling group 

# defines and provide a cluster 
resource "aws_ecs_cluster" "microservices-cluster" {
    name = "microservices-cluster"
}

# launch configuration
resource "aws_launch_configuration" "microservices-launchconfig" {
  name_prefix          = "ecs-launchconfig"
  image_id             = "${lookup(var.ECS_AMIS, var.AWS_REGION)}"
  instance_type        = "${var.ECS_INSTANCE_TYPE}"
  # key.tf
  key_name             = "${aws_key_pair.aws-key.key_name}"
  # add permissions to access ecr etc
  iam_instance_profile = "${aws_iam_instance_profile.ecs-ec2-role.id}"
  # security groups
  security_groups      = ["${aws_security_group.ecs-securitygroup.id}"]
  # config iam with microservices-cluster and start ecs agent
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=microservices-cluster' > /etc/ecs/ecs.config\nstart ecs"
  # in case we make any changes to our launch config terraform is going to create a new one before destroying the old one
  lifecycle              { create_before_destroy = true }
}

# autoscaling group
resource "aws_autoscaling_group" "microservices-autoscaling" {
  name                 = "ecs-microservices-autoscaling"
  # vpcs zone using subnets provided in vpc.tf
  vpc_zone_identifier  = ["${aws_subnet.subnet-public-1.id}", "${aws_subnet.subnet-public-2.id}"]
  # launch config refered above
  launch_configuration = "${aws_launch_configuration.microservices-launchconfig.name}"
  # min and max size can be update to scaling to launch multiple instances of a container
  min_size             = 1
  max_size             = 1
  # whenever we launch an instance it's going to have ecs-ec2-container
  tag {
      key = "Name"
      value = "ecs-ec2-container"
      propagate_at_launch = true
  }
}