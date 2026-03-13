variable "aws_region" {}

variable "ingress_rules" {
  description = "List of ingress rules with specific ports and CIDRs"
  type = list(object({
    port        = number
    description = string
    cidr_blocks = list(string)
  }))
}

variable "ami_id" {}
variable "instance_type" {}
variable "ssh_key" {}

variable "root_volume_size" {
  type    = number
  default = 10

  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 20
    error_message = "The root_volume_size must be between 8 and 20 GB."
  }
}

variable "owner_name" {}