# nat gateway

# Elastical IP Address 
resource "aws_eip" "nat" {
  vpc      = true
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.subnet-public-1.id}"
  depends_on = ["aws_internet_gateway.igw"]
}

# VPC setup for NAT
resource "aws_route_table" "rt-private" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }

    tags {
        Name = "rt-private"
    }
}
# Route Table Associations Private
resource "aws_route_table_association" "rta-private-1" {
    subnet_id = "${aws_subnet.subnet-private-1.id}"
    route_table_id = "${aws_route_table.rt-private.id}"
}
resource "aws_route_table_association" "rta-private-2" {
    subnet_id = "${aws_subnet.subnet-private-2.id}"
    route_table_id = "${aws_route_table.rt-private.id}"
}
resource "aws_route_table_association" "rta-private-3" {
    subnet_id = "${aws_subnet.subnet-private-3.id}"
    route_table_id = "${aws_route_table.rt-private.id}"
}
