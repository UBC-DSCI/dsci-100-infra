## Pre-requisites
  * You must have Terraform installed on your computer
  * You must have the Terraform-libvirt provider plugin installed (or configure
    another provider)

## WARNING
The terraform-libvirt-plugin has some issues with the way that user_data and
ssh_authentication_keys are handled. The upshot is that the cloudinit portion
of the terraform statefile isn't idempotent. If you run it again, it will tell
you it wants to change things. This has been noted as an issue in
https://github.com/dmacvicar/terraform-provider-libvirt/issues/313, but until
it is fixed, try to avoid re-applying the terraform. If you do run it, it
should happily change those resources, but it shouldn't have any effect on your
instances.

