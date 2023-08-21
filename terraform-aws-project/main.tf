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

#NAT Gateway Creation
module "NAT-Gateway" {
  source                     = "../modules/NAT-Gateway"
  Public-Subnet-AZ2-ID       = module.vpc.Public-Subnet-AZ2-ID
  Public-Subnet-AZ1-ID       = module.vpc.Public-Subnet-AZ1-ID
  Internet-Gateway           = module.vpc.Internet-Gateway
  VPC_ID                     = module.vpc.VPC_ID
  Private-App-Subnet-AZ1-ID  = module.vpc.Private-App-Subnet-AZ1-ID
  Private-Data-Subnet-AZ1-ID = module.vpc.Private-Data-Subnet-AZ1-ID
  Private-App-Subnet-AZ2-ID  = module.vpc.Private-App-Subnet-AZ2-ID
  Private-Data-Subnet-AZ2-ID = module.vpc.Private-Data-Subnet-AZ2-ID
}

#Security Group Module
module "Security_Group" {
  source = "../modules/Security-Groups"
  VPC_ID = module.vpc.VPC_ID
}

#ECS Role
module "ECS-TaskExecutionRole" {
  source       = "../modules/ECS-TaskExecution-Role"
  Project_Name = module.vpc.Project_Name
}
#Certificate
module "acm" {
  source           = "../modules/acm"
  domain_name      = var.domain_name
  alternative_name = var.alternative_name
}
#ALB
module "Application_Load_Balancer" {
  source               = "../modules/alb"
  Project_Name         = module.vpc.Project_Name
  ALB-SG-ID            = module.Security_Group.ALB-SG-ID
  Public-Subnet-AZ1-ID = module.vpc.Public-Subnet-AZ1-ID
  Public-Subnet-AZ2-ID = module.vpc.Public-Subnet-AZ2-ID
  VPC_ID               = module.vpc.VPC_ID
  certificate_arn      = module.acm.certificate_arn
}