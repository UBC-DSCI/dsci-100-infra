# Server Setup

## Instructions

1.  SSH into Hypervisor 
2.  use Git to clone this repository and move into the `terraform` directory
3.  Run the following 3 commands:
    - `terraform init`
    - `terraform plan`
    - `terraform apply`
4.  Navigate to the `ansible` directory 
4.  run `setup` target from Makefile
4.  Use ansible to setup hub using the commands that would be equivalend to 
     - `make ansible/setup` > gets external roles
     - `make hub/init` > updates kernel 
     - `make hub/apply` > builds JupyterHub (this is the step we are iterating over
     
5.  ansible hub - iterate here until ltiauth is working

*eventually terraform state file needs to live in an S3 bucket*

```
ssh stty2u@<hypervisor address>
virsh list
virsh domifaddr <name>

ls ../keys/id_syzygy_stat
ssh -i <ip addr of hub>
```

## To Check

- [ ] Is the pre-spawn hook defined in the correct place?

  ```
  ansible/roles/internal/jupyterhub/templates/jupyterhub_config_base.py.j2
  ```

- [ ] Do we need to use this for the hub_ip?

  ```python
  from jupyter_client.localinterfaces import public_ips
  c.JupyterHub.hub_ip = public_ips()[0]
  ```

- [ ] Is pycurl isntalling correctly?

If not:

```sh
sudo yum install python36u-devel openssl-devel
PYCURL_SSL_LIBRARY=openssl sudo -E pip3.6 install pycurl
```

- [ ] Did I set the Apache proxy header correctly?

  ```
    <Location /jupyter>
      ProxyPass http://127.0.0.1:8000/jupyter
      ProxyPassReverse http://127.0.0.1:8000/jupyter
      ProxyPreserveHost on
      RequestHeader set X-Forwarded-Proto "https"
    </Location>
  ```

- [ ] Should we update git?

- [ ] To specify at runtime:

  - Canvas API Token
  - LTI Consumer Key
  - LTI Consumer Secret

- [ ] Can we specify the course name?

- [ ] Is ltiauthenticator installing?

  Is this yaml file being sourced, and if not, how would it be?

  ```
  ansible/roles/internal/ltiauthenticator/main.yml
  ```

## Grading Server:

```bash
pip install rudaux
pip install nbgrader

sudo jupyter nbextension install --sys-prefix --py nbgrader --overwrite
sudo jupyter nbextension enable --sys-prefix --py nbgrader
sudo jupyter serverextension enable --sys-prefix --py nbgrader
```
