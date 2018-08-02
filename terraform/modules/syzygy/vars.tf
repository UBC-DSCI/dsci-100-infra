variable "default_user" {
  description = "Cloud-init and ssh user"
  default     = "stty2u"
}

variable "public_key" {
  description = "Cloud init and ssh user public key"
}

variable "storage_pool" {
  description = "libvirt storage pool to use"
  default     = "default"
}

variable "cloud_image" {
  description = "Cloud image to create instances from"
  default     = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-20150628_01.qcow2"
}

variable "network_name" {
  description = "Network new instances should be placed on"
}

variable "vcpu" {
  description = "Number of VCPUs to allocate to new instances"
  default = 1
}

variable "memory" {
  description = "Amount of memory to allocate to new instances"
  default = 1024
}

variable "environment" {
  description = "Environment to place instances in"
  default = "staging"
}
