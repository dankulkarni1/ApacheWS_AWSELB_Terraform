variable "aws_region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnets_cidr" {
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

# variable "private_subnets_cidr" {
# 	default = ["10.20.3.0/24", "10.20.4.0/24"]
# }

variable "azs" {
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "webservers_ami" {
  default = "ami-0bb3fad3c0286ebd5"
}

variable "instance_type" {
  default = "t2.micro"
}


