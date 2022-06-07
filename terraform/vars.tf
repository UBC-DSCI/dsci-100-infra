variable "ami" {
  description = "Amazon Machine Image identifier"
  default     = "ami-03f9f1c20c7f168e3"
}

variable "instance_type" {
  description = "Instance type to use"
  default     = "t2.small"
}

variable "key_name" {
  description = "Public key for ssh authentication"
  default     = "AWS_admin"
}

variable "region" {
    description = "AWS region"
    default     = "ca-central-1"
}

variable "availability_zone" {
    description = "Availability zone within region"
    default     = "ca-central-1a"
}

variable "docker_size" {
    description = "Default size of docker ephemeral storage"
    default     = 16
}

variable "zfs_size" {
    description = "Default size of zfs/home storage"
    default     = 16
}
