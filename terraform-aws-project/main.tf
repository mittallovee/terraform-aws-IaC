#Configure Provider
provider "aws" {
  region = var.Region
}

#VPC Creation
module "vpc" {
  source                       = "../modules/vpc"
  Project_Name                 = var.Project_Name
  Region                       = var.Region
  VPC_CIDR                     = var.VPC_CIDR
  public_subnet_AZ1_CIDR       = var.public_subnet_AZ1_CIDR
  public_subnet_AZ2_CIDR       = var.public_subnet_AZ2_CIDR
  private_app_subnet_AZ1_CIDR  = var.private_app_subnet_AZ1_CIDR
  private_app_subnet_AZ2_CIDR  = var.private_app_subnet_AZ2_CIDR
  private_data_subnet_AZ1_CIDR = var.private_data_subnet_AZ1_CIDR
  private_data_subnet_AZ2_CIDR = var.private_data_subnet_AZ2_CIDR
}