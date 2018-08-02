provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "syzygy_network" {
  name = "syzygy_network"
  addresses = ["192.168.123.0/24"]
}

module "syzygy" {
  source = "../../modules/syzygy"

  storage_pool = "local-images"
  public_key   = "${file("../../keys/id_syzygy_stat.pub")}"
  cloud_image  = "/var/lib/libvirt/local-images/CentOS-7-x86_64-GenericCloud-1805.qcow2"
  network_name = "${libvirt_network.syzygy_network.name}"
  environment  = "production"
}

