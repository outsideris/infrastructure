resource "cloudflare_zone" "outsider_dev" {
  account_id = var.cloudflare_account_id
  zone       = "outsider.dev"
}
