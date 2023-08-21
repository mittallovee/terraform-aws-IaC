
#Launch Template
resource "aws_launch_template" "terraform-launch-template" {
  name_prefix            = "${var.projectName}-lp"
  image_id               = var.instance-ami
  instance_type          = var.instance-type
  key_name               = var.instance-key-name
	user_data = base64encode(file("userdata.sh"))
  vpc_security_group_ids = [var.SG-EC2-ID]
}
#ASG
resource "aws_autoscaling_group" "terraform-asg" {
  name = "${var.projectName}-asg"
  desired_capacity    = var.desired-capacity
  max_size            = var.max-size
  min_size            = var.min-size
  vpc_zone_identifier = [var.public-subnet-1-ID, var.public-subnet-2-ID]
  launch_template {
    id      = aws_launch_template.terraform-launch-template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg-tg" {
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.id
  lb_target_group_arn    = var.lb-tg-arn
}



# # scale up policy
# resource "aws_autoscaling_policy" "terraform-scale_up" {
#   name                   = "terraform-asg-scale-up"
#   autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "1" #increasing instance by 1 
#   cooldown               = "300"
#   policy_type            = "SimpleScaling"
# }

# # scale up alarm
# # alarm will trigger the ASG policy (scale/down) based on the metric (CPUUtilization), comparison_operator, threshold
# resource "aws_cloudwatch_metric_alarm" "terraform-scale_up_alarm" {
#   alarm_name          = "terraform-asg-scale-up-alarm"
#   alarm_description   = "asg-scale-up-cpu-alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "30" # New instance will be created once CPU utilization is higher than 30 %
#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.terraform-asg.name
#   }
#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.terraform-scale_up.arn]
# }

# # scale down policy
# resource "aws_autoscaling_policy" "terraform-scale_down" {
#   name                   = "terraform-asg-scale-down"
#   autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "-1" # decreasing instance by 1 
#   cooldown               = "300"
#   policy_type            = "SimpleScaling"
# }

# # scale down alarm
# resource "aws_cloudwatch_metric_alarm" "terraform-scale_down_alarm" {
#   alarm_name          = "terraform-asg-scale-down-alarm"
#   alarm_description   = "asg-scale-down-cpu-alarm"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "5" # Instance will scale down when CPU utilization is lower than 5 %
#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.terraform-asg.name
#   }
#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.terraform-scale_down.arn]
# }