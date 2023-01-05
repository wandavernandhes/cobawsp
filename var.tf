//Region
variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

//Access Key & Secret Key
variable "access_key" {
  default = "AKIAUC3D7FDAGNLCXPO7"
}
variable "secret_key" {
  default = "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"
}

//Tag
variable "Birthday" {
  default = "26-01-2022"
}

//Backup
variable "Backup" {
  default = "BackupDaily"
}
variable "region" {
  default = "us-east-1"
}

//VPC
variable "cidr" {
  default = "192.168.0.0/20"
}

//Subnet
variable "Public_Subnet_AZ1" {
  default = "192.168.0.0/23"
}
variable "Public_Subnet_AZ2" {
  default = "192.168.2.0/23"
}
variable "App_Subnet_AZ1" {
  default = "192.168.4.0/23"
}
variable "App_Subnet_AZ2" {
  default = "192.168.6.0/23"
}
variable "Data_Subnet_AZ1" {
  default = "192.168.8.0/23"
}
variable "Data_Subnet_AZ2" {
  default = "192.168.10.0/23"
}

#AMI EC2
variable "ami-ubuntu" {
  default = "ami-04505e74c0741db8d"
}
variable "ami-linux2" {
  default = "ami-09d3b3274b6c5d4aa"
}

#Tagging Common
variable "environment" {
  default = "poc"
}
variable "environment_dev" {
  default = "dev"
}
variable "project" {
  default = "namacustomer"
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "Yes"
  }

  common_tags_dev = {
    Project     = var.project
    Environment = var.environment_dev
    Terraform   = "Yes"
  }
}

variable "customer" {
  default = "nama customer"
}

#Key
variable "key-bastion-inject" {
  default = "bastion-inject"
}

variable "key-sandbox-prod-app" {
  default = "key-sandbox-prod-app"
}

variable "key-sandbox-dev-app" {
  default = "key-sandbox-dev-app"
}

variable "key-sandbox-data" {
  default = "key-sandbox-data"
}

variable "key-sandbox-openvpn" {
  default = "key-sandbox-openvpn"
}