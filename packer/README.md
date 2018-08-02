# Packer for Syzygy-CentOS-7-x86_64-GenericCloud-1805-1

This directory contains the files for packer to build a base image for
the syzygy guests. The starting point is one of the
CentOS-7-x86_64-GenericCloud images and we use cloud-init to manage the
default user and perform any other necessary housekeeping tasks.


## Pre-requisites

Access is ssh-based, so we will need an ssh-key. Ideally the key should
be encrypted with a passphrase, but this can make life difficult with
packer so just make sure it is stored somewhere encrypted (a LUKS volume
works well).

```
 $ ssh-keygen -t rsa -b 4096 -f ../keys/id_syzygy_stats
```

## Cloud-init

The qemu packer builder is quit limited, and there aren't natural hooks
for passing `cloud-init.cfg`. Instead, we can use the cloud-utils to
build a floppy image containing our config and pass that in the qemu
builder arguments
```
  $ vi cloud-init.cfg
#cloud-config
ssh_authorized_keys:
  - SSH_PUBLIC_KEY_FROM_ABOVE
system_info:
  default_user:
    stty2u

  $ cloud-localds cloud.fda cloud_init.cfg
wrote cloud_init.fda with filesystem=iso9660 and diskformat=raw
```


## Packer build

The packer build file
```
  $ vi Syzygy-CentOS-7-x86_64-GenericCloud-1805-1.json
{
  "builders":
  [
    {
      "type": "qemu",
      "disk_image": true,
      "iso_url":
"https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1805.qcow2",
      "iso_checksum_url":
"https://cloud.centos.org/centos/7/images/sha256sum.txt",
      "iso_checksum_type": "sha256",
      "output_directory": "output",
      "shutdown_command": "echo 'packer' | sudo -S shutdown -P now",
      "disk_size": 10000,
      "format": "qcow2",
      "headless": true,
      "accelerator": "kvm",
      "ssh_username": "centos",
      "ssh_port": 22,
      "ssh_private_key_file": "../keys/id_syzygy_stat",
      "ssh_wait_timeout": "300s",
      "vm_name": "Syzygy-CentOS-7-x86_64-GenericCloud-1805-1.qcow2",
      "disk_interface": "virtio",
      "boot_wait": "5s",
      "qemuargs": [
        ["-m", "2048M"],
        ["-smp", "2"],
        ["-fda", "cloud.img"],
        ["-serial", "mon:stdio"]
      ]
    }
  ]
}

  $ packer validate Syzygy-CentOS-7-x86_64-GenericCloud-1805-1.json

  $ packer build Syzygy-CentOS-7-x86_64-GenericCloud-1805-1.json
```

We'll refer to this packer image in terraform next.
```
