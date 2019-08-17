#cloud-config
preserve_hostname: true

ssh_authorized_keys:
  - ${public_key}

system_info:
  default_user:
    name: ${default_user}
    ssh-authorized-keys:
      - ${public_key}

users:
  - default

