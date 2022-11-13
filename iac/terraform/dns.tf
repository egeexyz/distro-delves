data "aws_route53_zone" "egee_io" {
  name = "egee.io"
}

resource "aws_route53_record" "primary" {
  zone_id = data.aws_route53_zone.egee_io.id
  name    = "delve.egee.io"
  type    = "A"
  ttl     = "300"
  records = [aws_spot_instance_request.primary.public_ip]
}