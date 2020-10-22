# VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "WebServer-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  tags = {
    Name = "WebServer-IGW"
  }
}

# Subnets : public
resource "aws_subnet" "public" {
  count                   = "${length(var.subnets_cidr)}"
  vpc_id                  = "${aws_vpc.terra_vpc.id}"
  cidr_block              = "${element(var.subnets_cidr, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "PUBLIC-Subnet-${count.index + 1}"
  }
}

# # Subnets : private
# resource "aws_subnet" "private" {
#   count = "${length(var.private_subnets_cidr)}"
#   vpc_id = "${aws_vpc.terra_vpc.id}"
#   cidr_block = "${element(var.private_subnets_cidr,count.index)}"
#   availability_zone = "${element(var.azs,count.index)}"
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "PRIVATE-Subnet-${count.index+1}"
#   }
# }

# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terra_igw.id}"
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# # Route table: Private
# resource "aws_route_table" "private_rt" {
#   vpc_id = "${aws_vpc.terra_vpc.id}"

#   tags = {
#     Name = "PrivateRouteTable"
#   }
# }


# Route table association with public subnets
resource "aws_route_table_association" "public" {
  count          = "${length(var.subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_rt.id}"
}


# resource "aws_route_table_association" "private" {
#   count          = "${length(var.private_subnets_cidr)}"
#   subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
#   route_table_id = "${aws_route_table.private_rt.id}"
# }