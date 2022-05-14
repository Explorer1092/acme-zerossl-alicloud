
terraform {
  required_providers {
    zerossl = {
      source = "toowoxx/zerossl"
      // version = "0.1.1"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.8.0"
    }
  }
}

/*
* 申请证书
*/
resource "zerossl_eab_credentials" "eab_credentials" {
  api_key = var.zerossl_key
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "nobody@nobody.com"
  external_account_binding {
    key_id      = zerossl_eab_credentials.eab_credentials.kid
    hmac_base64 = zerossl_eab_credentials.eab_credentials.hmac_key
  }
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name

  dns_challenge {
    provider = "alidns"
    config = {
      ALICLOUD_ACCESS_KEY = var.aliyun_access_key
      ALICLOUD_SECRET_KEY = var.aliyun_secret_key
      ALICLOUD_HTTP_TIMEOUT = 600
    }
  }

}