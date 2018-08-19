# extra volume data 
resource "aws_ebs_volume" "ebs-volume" {
    availability_zone = "us-east-1a"
    size = 20 # GB 
    type = "gp2" # ssd
    tags {
        Name = "extra volume data"
    }
}

# attach volume to the instance
resource "aws_volume_attachment" "ebs-volume-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.ebs-volume.id}"
  instance_id = "${aws_instance.us-east-1-instance.id}"
}
