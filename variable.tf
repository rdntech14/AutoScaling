variable "AWS_REGION" {
  default     = "us-east-1"
  description = "This is AWS region name"
}

# ELB variables
variable "elb_name" {
  default     = "elb-trf"
  description = "This is ELB name"
}

variable "elb_security_group" {
  type        = "list"
  default     = ["sg-b3422ac6"]
  description = "This is ELB security group"
}

variable "elb_zones" {
  type        = "list"
  default     = ["us-east-1a", "us-east-1b"]
  description = "This is availability_zones assciate with ELB"
}

# Launch Configuration variables
variable "lc_name" {
  default     = "AS_LC_TRF"
  description = "This is instance type"
}

variable "lc_ami_image_id" {
  default     = "ami-1853ac65"
  description = "This is aws region name"
}

variable "lc_instance_type" {
  default     = "t2.micro"
  description = "This is instance type"
}

variable "lc_zones" {
  type        = "list"
  default     = ["us-east-1a", "us-east-1b"]
  description = "This is availability_zones assciate with ELB"
}

# Auto Scaling Group variables
variable "auto_scaling_group_name" {
  default     = "TRF_AS_GRP2"
  description = "This is auto scaling lanuch configuration name"
}

variable "as_group_zones" {
  type        = "list"
  default     = ["subnet-a05538eb", "	subnet-e0e832bd"]
  description = "This is availability_zones assciate with ELB"
}
