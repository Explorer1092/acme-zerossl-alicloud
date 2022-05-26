# acme-zerossl-alicloud


```
terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.168.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.8.0"
    }
    zerossl = {
      source = "toowoxx/zerossl"
    }
  }
}

variable "zerossl_key" {
    description = "ZeroSSL Key"
}

variable "domain" {

}

provider "acme" {
  server_url = "https://acme.zerossl.com/v2/DV90"
}


module "zerossl_alicloud" {
  source  = "Explorer1092/zerossl_alicloud/x"
  version = "1.0.3"
  aliyun_access_key = var.dns_aliyun_access_key
  aliyun_secret_key = var.dns_aliyun_secret_key
  common_name = var.domain
  zerossl_key = var.zerossl_key
}

output "certificate_pem" {
    value =  module.zerossl_alicloud.certificate_pem
}

output "private_key" {
    value = module.zerossl_alicloud.private_key
}

```