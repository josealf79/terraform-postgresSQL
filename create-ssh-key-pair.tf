resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pk" {
  key_name   = "pk"
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./pk.pem"
  }
}

resource "local_file" "pk" {
  filename             = pathexpand("./pk.pem")
  file_permission      = "600"
  directory_permission = "700"
  sensitive_content    = tls_private_key.pk.private_key_pem
}
