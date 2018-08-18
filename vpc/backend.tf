terraform {
    backend "s3" {
        bucket = "terraform-remote-state-us-east-virginia"
        key = "terraform/us-east-1-instance"
    }
}