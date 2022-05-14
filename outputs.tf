
output "private_key" {
  value = acme_certificate.certificate.private_key_pem
}

output "certificate_pem" {
  value = acme_certificate.certificate.certificate_pem
}
