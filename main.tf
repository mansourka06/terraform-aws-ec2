### terraform-aws-ec2/main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "${var.region}"
}

#########################################################
# Ressources
#########################################################

################ EC2 #######################
resource "aws_instance" "myec2" {
  ami           = "${var.amazon_amis}"
  instance_type = "${var.instance_type}"

  tags = {
    Name = "myec2_server"
  }

  root_block_device {
    delete_on_termination = true
  }
 }

################### cluseter ##############################
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.ecs_cluster_name}"
}

##################### VPC #################################
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "terraform-aws-vpc"
  }
}

######################### Gateway ##############################
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

####################### Public subnet #########################
resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_cidr_block1}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.default"]
  availability_zone       = "${lookup(var.availability_zone,"primary")}"

  tags {
    Name = "My Public Subnet"
  }
}

resource "aws_route_table" "public-One-Route" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Public Subnet One"
  }
}

resource "aws_route_table_association" "public-Assoc-One" {
  subnet_id      = "${aws_subnet.public-One.id}"
  route_table_id = "${aws_route_table.public-One-Route.id}"
}


