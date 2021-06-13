resource "null_resource" "validate_hetzner_api_token" {
  provisioner "local-exec" {
    command     = "echo ${var.hetzner_api_token}"
    interpreter = ["sh", "-c"]
  }
}

resource "null_resource" "validate_arn" {
  provisioner "local-exec" {
    command     = "echo ${var.server_role_arn}"
    interpreter = ["sh", "-c"]
  }
}

resource "null_resource" "validate_env" {
  provisioner "local-exec" {
    command     = "echo ${var.env}"
    interpreter = ["sh", "-c"]
  }
}

resource "null_resource" "validate_hetzner_server_type" {
  provisioner "local-exec" {
    command     = "echo ${var.hetzner_server_type}"
    interpreter = ["sh", "-c"]
  }
}

resource "null_resource" "validate_hetzner_datacenters" {
  provisioner "local-exec" {
    command     = "echo ${join(", ", var.hetzner_datacenters)}"
    interpreter = ["sh", "-c"]
  }
}
