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
  default     = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
}

variable "vcpu" {
  description = "Number of VCPUs to allocate to new instances"
  default     = 1
}

variable "memory" {
  description = "Amount of memory to allocate to new instances"
  default     = 1024
}

variable "hub_fqdn" {
  description = "hub fully qualified domain name"
}

variable "mark_fqdn" {
  description = "marker fully qualified domain name"
}

variable "environment" {
  description = "Environment to place instances in"
  default     = "staging"
}

variable "docker_disk_size" {
  description = "Disk size for backing docker volume"
  default     = "32212254720"
}

variable "zfs_disk_size" {
  description = "Disk size for backing docker volume"
  default     = "137438953472"
}

variable "hub_bridge" {
  description = "Network bridge to place hub interface on"
}

variable "hub_mac" {
  description = "Mac address to assign to hub network interface"
}

variable "hub_address" {
  description = "IP address to assign to hub network interface"
}

variable "mark_bridge" {
  description = "Network bridge to place marker interface on"
}

variable "mark_mac" {
  description = "Mac address to assign to marker network interface"
}

variable "mark_address" {
  description = "IP address to assign to marker network interace"
}

