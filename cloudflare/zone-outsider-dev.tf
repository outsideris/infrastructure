resource "cloudflare_zone" "outsider_dev" {
  account_id = var.cloudflare_account_id
  zone       = "outsider.dev"
}

resource "cloudflare_record" "teslamate" {
  zone_id = cloudflare_zone.outsider_dev.id
  name    = "teslamate"
  value   = "158.247.242.91"
  type    = "A"
  ttl     = 3600
  proxied = false
}
resource "cloudflare_record" "tesla_grafana" {
  zone_id = cloudflare_zone.outsider_dev.id
  name    = "tesla-grafana"
  value   = "158.247.242.91"
  type    = "A"
  ttl     = 3600
  proxied = false
}
