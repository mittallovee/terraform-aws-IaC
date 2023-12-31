#VPC related variables
variable "Project_Name" {}
variable "Region" {}
variable "VPC_CIDR" {}
variable "public_subnet_AZ1_CIDR" {}
variable "public_subnet_AZ2_CIDR" {}
variable "private_app_subnet_AZ1_CIDR" {}
variable "private_app_subnet_AZ2_CIDR" {}
variable "private_data_subnet_AZ1_CIDR" {}
variable "private_data_subnet_AZ2_CIDR" {}
variable "domain_name" {}
variable "alternative_name" {}
variable "instance-ami" {}
variable "instance-type" {}
variable "instance-key" {}
variable "asg-desired-capacity" {}
variable "asg-max-size" {}
variable "asg-min-size" {}



