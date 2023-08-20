output "Region" {
  value = var.Region
}
output "Project_Name" {
  value = var.Project_Name
}
output "VPC_CIDR" {
  value = var.VPC_CIDR
}
output "VPC_ID" {
  value = aws_vpc.vpc.id
}
output "Public-Subnet-AZ1-ID" {
  value = aws_subnet.public_subnet_AZ1.id
}
output "Public-Subnet-AZ2-ID" {
  value = aws_subnet.public_subnet_AZ2.id
}
output "Private-App-Subnet-AZ1-ID" {
  value = aws_subnet.private_app_subnet_AZ1.id
}
output "Private-App-Subnet-AZ2-ID" {
  value = aws_subnet.private_app_subnet_AZ2.id
}
output "Private-Data-Subnet-AZ1-ID" {
  value = aws_subnet.private_data_subnet_AZ1.id
}
output "Private-Data-Subnet-AZ2-ID" {
  value = aws_subnet.private_data_subnet_AZ2.id
}
output "Internet-Gateway" {
  value = aws_internet_gateway.IGW.id
}



