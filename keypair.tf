#generate key-pair for the instance
#by Ali Akturin for CS312 System Administration Project 2

#should work with tls_private_key but doesn't, setting up manual key pair creation for now
resource "aws_key_pair" "kp" {
  key_name   = "mc_ec2_key" # Create "mc_ec2_key" to AWS!!
  public_key = file("~/.ssh/mc_server_auto.pub")
}