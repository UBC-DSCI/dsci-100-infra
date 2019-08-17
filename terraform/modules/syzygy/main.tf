data "template_file" "cloud_init" {
  template = file("${path.module}/cloud_init.cfg.tpl")

  vars = {
    default_user = var.default_user
    public_key   = var.public_key
  }
}

provider random {
  version = "~> 2.2"
}

resource "random_string" "suffix" {
  length = 8
  special = false
}

resource "libvirt_cloudinit_disk" "commoninit" {
  #
  # N.B. this is not idempotent, see 
  # https://github.com/dmacvicar/terraform-provider-libvirt/issues/313
  # 
  name      = "commoninit-${random_string.suffix.result}.iso"
  pool      = var.storage_pool
  user_data = data.template_file.cloud_init.rendered
}

resource "libvirt_volume" "hub_root_disk" {
  name   = "${var.hub_fqdn}-root.qcow2"
  pool   = var.storage_pool
  source = var.cloud_image
}

resource "libvirt_volume" "hub_zfs_disk" {
  name = "${var.hub_fqdn}-zfs.qcow2"
  pool = var.storage_pool
  size = var.zfs_disk_size
}

resource "libvirt_volume" "hub_docker_disk" {
  name = "${var.hub_fqdn}-docker.qcow2"
  pool = var.storage_pool
  size = var.docker_disk_size
}

resource "libvirt_domain" "hub" {
  name = var.hub_fqdn

  vcpu   = var.vcpu
  memory = var.memory

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    bridge         = var.hub_bridge
    addresses      = [var.hub_address]
    mac            = var.hub_mac
    #wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.hub_root_disk.id
  }

  disk {
    volume_id = libvirt_volume.hub_zfs_disk.id
  }

  disk {
    volume_id = libvirt_volume.hub_docker_disk.id
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }
}

resource "ansible_group" "environment" {
  inventory_group_name = var.environment
}

resource "ansible_group" "hubs" {
  inventory_group_name = "hubs"
}

resource "ansible_host" "hub" {
  inventory_hostname = var.hub_fqdn
  groups = [
    "all",
    ansible_group.hubs.inventory_group_name,
    ansible_group.environment.inventory_group_name,
  ]
}

resource "libvirt_volume" "marking_root_disk" {
  name   = "${var.mark_fqdn}.qcow2"
  pool   = var.storage_pool
  source = var.cloud_image
}

resource "libvirt_volume" "marking_zfs_disk" {
  name = "${var.mark_fqdn}-zfs.qcow2"
  pool = var.storage_pool
  size = var.zfs_disk_size
}

resource "libvirt_volume" "marking_docker_disk" {
  name = "${var.mark_fqdn}-docker.qcow2"
  pool = var.storage_pool
  size = var.docker_disk_size
}

resource "libvirt_domain" "marking" {
  name = var.mark_fqdn

  vcpu   = var.vcpu
  memory = var.memory

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    bridge         = var.mark_bridge
    mac            = var.mark_mac
    addresses      = [var.mark_address]
    #wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.marking_root_disk.id
  }

  disk {
    volume_id = libvirt_volume.marking_zfs_disk.id
  }

  disk {
    volume_id = libvirt_volume.marking_docker_disk.id
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }
}

resource "ansible_group" "markers" {
  inventory_group_name = "markers"
}

resource "ansible_host" "marking" {
  inventory_hostname = var.mark_fqdn
  groups = [
    "all",
    ansible_group.markers.inventory_group_name,
    ansible_group.environment.inventory_group_name,
  ]
}

