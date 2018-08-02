resource "random_pet" "hub_name" {
  length = 1
  prefix = "jhub"
}

resource "random_pet" "marking_name" {
  length = 1
  prefix = "mark"
}

data template_file cloud_init {

  template = "${file("${path.module}/cloud_init.cfg.tpl")}"

  vars = {
    default_user = "${var.default_user}"
  }

}

resource "libvirt_cloudinit" "commoninit" {
  #
  # N.B. this is not idempotent, see 
  # https://github.com/dmacvicar/terraform-provider-libvirt/issues/313
  # 
  name               = "commoninit.iso"
  pool               = "${var.storage_pool}"
  ssh_authorized_key = "${var.public_key}"
  user_data          = "${data.template_file.cloud_init.rendered}"
}

resource "libvirt_volume" "hub_root_disk" {
  name = "${random_pet.hub_name.id}.qcow2"
  pool = "${var.storage_pool}"
  source = "${var.cloud_image}"
}

resource "libvirt_volume" "marking_root_disk" {
  name = "${random_pet.marking_name.id}.qcow2"
  pool = "${var.storage_pool}"
  source = "${var.cloud_image}"
}

resource libvirt_domain hub {
  name = "${random_pet.hub_name.id}"

  vcpu   = "${var.vcpu}"
  memory = "${var.memory}"

  cloudinit = "${libvirt_cloudinit.commoninit.id}"

  network_interface {
    network_name = "${var.network_name}"
  }

  disk {
    volume_id = "${libvirt_volume.hub_root_disk.id}"
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

resource libvirt_domain marking {
  name = "${random_pet.marking_name.id}"

  vcpu   = "${var.vcpu}"
  memory = "${var.memory}"

  cloudinit = "${libvirt_cloudinit.commoninit.id}"

  network_interface {
    network_name = "${var.network_name}"
  }

  disk {
    volume_id = "${libvirt_volume.marking_root_disk.id}"
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

