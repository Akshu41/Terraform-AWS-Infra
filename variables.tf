variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for the first public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet"
  default     = "10.0.2.0/24"
}

variable "public_subnet_cidr_3" {
  description = "CIDR block for the third public subnet"
  default     = "10.0.3.0/24"
}
