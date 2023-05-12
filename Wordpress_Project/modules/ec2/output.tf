output "server_ip" {
  value = aws_instance.wordpress_server.public_ip
}