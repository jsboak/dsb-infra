variable "environment" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.31"
}

variable "vpc_cidr" {
  type = string
}

variable "corp_vpn_cidr" {
  description = "Corporate VPN range. Used for DNS and ingress allow lists."
  type        = string
  default     = "172.20.0.0/14"
}
