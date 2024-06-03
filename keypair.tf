#generate key-pair for the instance

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


#should work with tls_private_key but doesn't, setting up manual key pair creation for now
resource "aws_key_pair" "kp" {
  key_name   = "mc_ec2_key"      # Create "mc_ec2_key" to AWS!!
  public_key = file("~/.ssh/id_rsa.pub")

#   provisioner "local-exec" { # Create "ec2_key.pem" to your computer!!
#     command = <<-EOT
#       echo '${tls_private_key.pk.private_key_pem}' > ./'mc_ec2_key'.pem
#       chmod 404 ./'mc_ec2_key'.pem
#     EOT
#   }
}