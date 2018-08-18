# filtering traffic based on an aws region using security groups

# filtering traffic in aws using security groups (incoming and outgoing filtered by protocol, ip range and port)

# INPUT DATA (it will be pulled from aws that contains all the IP ranges for this region)
# see all ips from us-east-1	and us-east-2 (ohio and n. virginia)
# only want to use it for ec2 services
data "aws_ip_ranges" "us_east_ec2" {
  #regions = [ "us-east-1", "us-east-2" ]
  regions = [ "us-east-1"]
  services = [ "ec2" ] 
}

# the input data will use in our security group
resource "aws_security_group" "from_us_east" {
 name = "from_us_east"

  # incoming rule for incoming traffic
  ingress {
    # aws security group inputs
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    # allowing the IPs from these IP ranges
    # cidr_blocks attribute is a range of ips from input data us_east_ec2 
    cidr_blocks = [ "${data.aws_ip_ranges.us_east_ec2.cidr_blocks}" ] 
  }
  # tags of when it was created and sync token 
  # if the data changes, then this sync token will change
  tags {
    CreateDate = "${data.aws_ip_ranges.us_east_ec2.create_date}"
    SyncToken = "${data.aws_ip_ranges.us_east_ec2.sync_token}" # next time that you run terraform apply it will update the security group again
  }

}
