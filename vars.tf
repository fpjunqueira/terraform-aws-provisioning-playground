# variables 

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
    default = "us-east-1"
}
variable "AMIS" {
    type = "map"
    default = {
        us-east-1 = "ami-ef151d90"
        us-west-1= "ami-d8b05cbb"
        us-west-2 = "ami-1cc69e64"
    }
  
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "../aws.pem"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../aws.pem"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
  