# Data source for VPC
data "aws_vpc" "default_vpc" {
  default = true
}

# Data source for Subnets
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

data "template_file" "wordpress" {
  template = file("./webserver.tpl")
}

# Wordpress Server
module "server" {
  source                 = "./modules/ec2"

  instance_name          = "wordpress_server"
  user_data              = base64encode(data.template_file.wordpress.rendered)
  security_group_ids      = module.security_group.sg-instance
}

#Security groups
module "security_group" {
  source = "./modules/sg"

  sg_name_prefix    = "wp-sg"
  vpc_id            = data.aws_vpc.default_vpc.id
}