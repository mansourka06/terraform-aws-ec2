### terraform-aws-ec2/variable.tf

variable "region" {
  default = "eu-west-3"
}

variable "amazon_amis" {
  type = map(string)
  default = {
    #ecs amis
    eu-west-3 = "ami-0493936afbe820b28"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "availability_zone" {
  type = map(string)

  default = {
    primary = "eu-west-3a"
  }
}

variable "ecs_cluster_name" {
  default = "mk_ec2_cluster"
}

variable "autoscale" {
  default = {
    min     = 2
    max     = 6
    desired = 2
  }
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_cidr_block1" {
  default = "10.0.128.0/20"
}
