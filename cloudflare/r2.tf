resource "cloudflare_r2_bucket" "retrotech" {
  account_id = var.cloudflare_account_id
  name       = "retrotech"
  location   = "APAC" # Asia-Pacific
}
