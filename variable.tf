variable "region" {
  type        = string
  default     = "ca-central-1"
  description = "Enter Your Region Name"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.20.0.0/16"
  description = "Enter VPC CIDR"
}

variable "subnet1_cidr" {
  type        = string
  default     = "10.20.1.0/24"
  description = "Enter Subnet1 CIDR"
}

variable "az1" {
  type        = string
  default     = "ca-central-1a"
  description = "Enter AZ1 Name"
}

variable "subnet2_cidr" {
  type        = string
  default     = "10.20.2.0/24"
  description = "Enter Subnet2 CIDR"
}

variable "subnet3_cidr" {
  type        = string
  default     = "10.20.3.0/24"
  description = "Enter Subnet3 CIDR"
}

variable "az2" {
  type        = string
  default     = "ca-central-1b"
  description = "Enter AZ2 Name"
}

variable "subnet4_cidr" {
  type        = string
  default     = "10.20.4.0/24"
  description = "Enter Subnet4 CIDR"
}

variable "sg_name" {
  type        = string
  default     = "TFPublicEC2SG"
  description = "Enter SG Name"
}

variable "ec2_ami" {
  type        = string
  default     = "ami-085f043560da76e08"
  description = "Enter EC2 AMI ID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Enter EC2 Instance Type"
}

variable "ec2_key_pair" {
  type        = string
  default     = "harun-canada-kpec2"
  description = "Enter EC2 Key Pair Name"
}


