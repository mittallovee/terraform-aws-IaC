#Security Group for ALB
resource "aws_security_group" "ALB-Security-Group" {
    name = "ALB_Security_Group"
    description = "Enabling ports 80,443 for HTTP, HTTPS"
    vpc_id = var.VPC_ID
    ingress {
        description = "Access HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Access HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Access All"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]      
    }  
    tags = {
        Name = "ALB Security Group"
    }
}

#Security Group for ECS
resource "aws_security_group" "ECS-Security-Group" {
    name = "ECS_Security_Group"
    description = "Enabling ports 80,443 for HTTP, HTTPS"
    vpc_id = var.VPC_ID
    ingress {
        description = "Access HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.ALB-Security-Group.id]
    }
    ingress {
        description = "Access HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = [aws_security_group.ALB-Security-Group.id]
    }
    egress {
        description = "Access All"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]      
    }  
    tags = {
        Name = "ECS Security Group"
    }
}