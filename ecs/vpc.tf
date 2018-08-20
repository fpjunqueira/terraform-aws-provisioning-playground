# Internet VPC
resource "aws_vpc" "vpc-us1-terraform-playground" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "vpc-us1-terraform-playground"
    }
}


# Public Subnets
resource "aws_subnet" "subnet-public-1" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "public-10.0.1.0/24"
    }
}
resource "aws_subnet" "subnet-public-2" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "public-10.0.2.0/24"
    }
}
resource "aws_subnet" "subnet-public-3" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"

    tags {
        Name = "public-10.0.3.0/24"
    }
}

# Private Subnets
resource "aws_subnet" "subnet-private-1" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "private-10.0.4.0/24"
    }
}
resource "aws_subnet" "subnet-private-2" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "private-10.0.5.0/24"
    }
}
resource "aws_subnet" "subnet-private-3" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "private-10.0.6.0/24"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"

    tags {
        Name = "igw"
    }
}

# Route Tables
resource "aws_route_table" "rt-public" {
    vpc_id = "${aws_vpc.vpc-us1-terraform-playground.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "rt-public"
    }
}

# Route Table Associations Public
resource "aws_route_table_association" "rta-public-1" {
    subnet_id = "${aws_subnet.subnet-public-1.id}"
    route_table_id = "${aws_route_table.rt-public.id}"
}
resource "aws_route_table_association" "rta-public-2" {
    subnet_id = "${aws_subnet.subnet-public-2.id}"
    route_table_id = "${aws_route_table.rt-public.id}"
}
resource "aws_route_table_association" "rta-public-3" {
    subnet_id = "${aws_subnet.subnet-public-3.id}"
    route_table_id = "${aws_route_table.rt-public.id}"
}
