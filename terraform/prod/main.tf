provider "libvirt" {
  uri = "qemu:///system"
}

module "syzygy" {
  source = "../modules/syzygy"

  storage_pool = "local-images"
  public_key   = file("../../keys/id_syzygy_stat.pub")
  cloud_image  = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
  hub_bridge   = "br0"
  hub_mac      = "2a:71:34:d5:e1:a5"
  hub_address  = "142.103.37.172"
  hub_fqdn     = "hub-prod-dsci.stat.ubc.ca"
  mark_bridge  = "br0"
  mark_mac     = "66:a5:b8:9c:ab:97"
  mark_address = "142.103.37.174"
  mark_fqdn    = "mark-prod-dsci.stat.ubc.ca"
#  mds_bridge   = "br0"
#  mds_mac      = "52:54:3b:18:fb:17"
#  mds_address  = "142.103.37.175"
#  mds_fqdn     = "mark-prod-mds.stat.ubc.ca"

  environment = "production"
}

