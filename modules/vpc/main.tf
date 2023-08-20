#VPC Creation
resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR
  instance_tenancy = "default"
  enable_dns_hostnames = true
    tags = {
      Name = "${var.Project_Name}-vpc"
    }
  }

#Internet Gateway(IGW) Creation and attachment with VPC
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.Project_Name}-igw"
  }
}

#Get List of all availability zones in selected region
data "aws_availability_zones" "all_availability_zones" {}

#Create Public Subnets in AZ1
resource "aws_subnet" "public_subnet_AZ1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_AZ1_CIDR
    availability_zone = data.aws_availability_zones.all_availability_zones.names[0]
    map_public_ip_on_launch = true
    tags = {
      Name = "Public Subnet AZ1"
    }
}
#Create Public Subnets in AZ2
resource "aws_subnet" "public_subnet_AZ2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_AZ2_CIDR
    availability_zone = data.aws_availability_zones.all_availability_zones.names[1]
    map_public_ip_on_launch = true
    tags = {
      Name = "Public Subnet AZ2"
    }
}

#Route Table Creation and adding public route
resource "aws_route_table" "public-RT" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }
    tags = {
        Name = "Public Route Table"
    }
}

#Association of Public Route Table with Public Subnet AZ1
resource "aws_route_table_association" "public-subnet-AZ1-RT-association" {
  subnet_id = aws_subnet.public_subnet_AZ1.id
  route_table_id = aws_route_table.public-RT.id
}
#Association of Public Route Table with Public Subnet AZ2
resource "aws_route_table_association" "public-subnet-AZ2-RT-association" {
  subnet_id = aws_subnet.public_subnet_AZ2.id
  route_table_id = aws_route_table.public-RT.id
}

#Create Private App Subnets in AZ1
resource "aws_subnet" "private_app_subnet_AZ1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_app_subnet_AZ1_CIDR
    availability_zone = data.aws_availability_zones.all_availability_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
      Name = "Private App Subnet AZ1"
    }
}
#Create Private App Subnets in AZ2
resource "aws_subnet" "private_app_subnet_AZ2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_app_subnet_AZ2_CIDR
    availability_zone = data.aws_availability_zones.all_availability_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
      Name = "Private App Subnet AZ2"
    }
}

#Create Private Data Subnets in AZ1
resource "aws_subnet" "private_data_subnet_AZ1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_data_subnet_AZ1_CIDR
    availability_zone = data.aws_availability_zones.all_availability_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
      Name = "Private Data Subnet AZ1"
    }
}
#Create Private App Subnets in AZ2
resource "aws_subnet" "private_data_subnet_AZ2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_data_subnet_AZ2_CIDR
    availability_zone = data.aws_availability_zones.all_availability_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
      Name = "Private Data Subnet AZ2"
    }
}
