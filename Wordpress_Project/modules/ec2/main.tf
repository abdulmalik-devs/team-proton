resource "aws_instance" "wordpress_server" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name      = "word"
  user_data     = var.user_data
  vpc_security_group_ids = ["${var.security_group_ids}"]

  tags = {
    Name = "${var.instance_name}"
  }
}