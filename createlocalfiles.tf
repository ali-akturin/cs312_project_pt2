resource "local_file" "private_key" {
  content  = aws_eip.mc_ip.public_ip
  filename = "server_ip.txt"
}