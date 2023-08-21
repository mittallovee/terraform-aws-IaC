#Getting Data of already created hosted zone
data "aws_route53_zone" "route53_zone_data" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "domain-alias-a" {
  zone_id = data.aws_route53_zone.route53_zone_data.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}