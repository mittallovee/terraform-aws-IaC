#Elastic IP for NAT Gateway in AZ1
resource "aws_eip" "EIP-NATGateway-AZ1" {
    domain = "vpc"
    tags = {
        Name = "NATGateway_EIP_AZ1"
    }
}
#Elastic IP for NAT Gateway in AZ2
resource "aws_eip" "EIP-NATGateway-AZ2" {
    domain = "vpc"
    tags = {
        Name = "NATGateway_EIP_AZ2"
    }
}

#NAT Gateway Creation in Public Subnet AZ1
resource "aws_nat_gateway" "NAT-Gateway-AZ1" {
    allocation_id = aws_eip.EIP-NATGateway-AZ1.id
    subnet_id = var.Public-Subnet-AZ1-ID
    tags = {
      Name = "NAT Gateway AZ1"
    }
    depends_on = [ var.Internet-Gateway ]
}
#NAT Gateway Creation in Public Subnet AZ2
resource "aws_nat_gateway" "NAT-Gateway-AZ2" {
    allocation_id = aws_eip.EIP-NATGateway-AZ2.id
    subnet_id = var.Public-Subnet-AZ2-ID
    tags = {
      Name = "NAT Gateway AZ2"
    }
    depends_on = [ var.Internet-Gateway ]
}

#Route Table Creation for Private Subnets in AZ1
resource "aws_route_table" "Private-RT-AZ1" {
    vpc_id = var.VPC_ID
    route  {
        cidr_block  = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NAT-Gateway-AZ1.id
    }
    tags = {
        Name = "Private RT AZ1"
    }
}
#Private Route Table Association with Private Subnet for App in AZ1
resource "aws_route_table_association" "Private_App_Subnet_Association_AZ1" {
    subnet_id = var.Private-App-Subnet-AZ1-ID
    route_table_id = aws_route_table.Private-RT-AZ1.id
}
#Private Route Table Association with Private Subnet for Data in AZ1
resource "aws_route_table_association" "Private_Data_Subnet_Association_AZ1" {
    subnet_id = var.Private-Data-Subnet-AZ1-ID
    route_table_id = aws_route_table.Private-RT-AZ1.id
}
#Route Table Creation for Private Subnets in AZ2
resource "aws_route_table" "Private-RT-AZ2" {
    vpc_id = var.VPC_ID
    route  {
        cidr_block  = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NAT-Gateway-AZ2.id
    }
    tags = {
        Name = "Private RT AZ2"
    }
}
#Private Route Table Association with Private Subnet for App in AZ2
resource "aws_route_table_association" "Private_App_Subnet_Association_AZ2" {
    subnet_id = var.Private-App-Subnet-AZ2-ID
    route_table_id = aws_route_table.Private-RT-AZ2.id
}
#Private Route Table Association with Private Subnet for Data in AZ2
resource "aws_route_table_association" "Private_Data_Subnet_Association_AZ2" {
    subnet_id = var.Private-Data-Subnet-AZ2-ID
    route_table_id = aws_route_table.Private-RT-AZ2.id
}
