Check the configuration in [ansible/ansible.cfg](ansible/ansible.cfg) and
update the inventory file.

Initialize the roles we need
```bash
$ ./ansible/scripts/role_update.sh
```

Initialize the hosts, basically, this will yum-update everything
```bash
$ cd ansible
$ ansible-playbook -i ./inventory plays/init.yml
```

Check and update the variables in the files under
[ansible/group_vars](ansible/group_vars). All of them are important, but check
[jupyterhub.yml](ansible/group_vars/jupyterhub.yml) and
[secrets.yml](ansible/group_vars/secrets.yml) in particular.
[secrets.yml](ansible/group_vars/secrets.yml) should be encrypted with
ansible-vault if you intend to commit it to the repository. 

  * admin_email, support_email
  * zfs_vdev_config
  * openstack_ephemeral_docker_disk
  * jupyterhub_auth_token (Can be generated with `openssl rand -hex 32`)
  * jupyterhub_cookie_secret (Can be generated with `openssl rand -hex 32`)
  * jupyterhub_lti_client_key (Get this from Canvas)
  * jupyterhub_lti_client_secret (Get this from Canvas)

