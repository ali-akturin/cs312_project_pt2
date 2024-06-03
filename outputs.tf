output "instance_public_ip" {
  description = "Minecraft Server IP address"
  value       = aws_eip.mc_ip.public_ip
}