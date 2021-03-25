resource "aws_acm_certificate" "cert" {
    domain_name       = "voidwalker.systems"
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }
}

data "aws_route53_zone" "primary_zone" {
    name         = "voidwalker.systems"
    private_zone = false
}

resource "aws_route53_record" "void_record" {
    zone_id = data.aws_route53_zone.primary_zone.zone_id
    name    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
    type    = "CNAME"
    ttl     = "5"
    records = [ tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
}

resource "aws_acm_certificate_validation" "validation_hold" {
    certificate_arn = aws_acm_certificate.cert.arn
    validation_record_fqdns = [aws_route53_record.void_record.fqdn]
}