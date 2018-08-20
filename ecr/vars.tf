variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "../aws-key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "../aws-key.pub"
}
variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
variable "ECS_AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-00129b193dc81bc31"
    us-east-2 = "ami-028a9de0a7e353ed9"
    us-west-1 = "ami-0d438d09af26c9583"
  }
}

