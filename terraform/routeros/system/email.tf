resource "routeros_tool_email" "purelymail" {
  server   = "smtp.purelymail.com"
  port     = "587"
  tls      = "starttls"
  from     = var.smtp_from
  user     = var.smtp_username
  password = var.smtp_password
}
