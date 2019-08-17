UNAME := $(shell uname | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)
TOP := $(shell pwd)
TF_PATH := $(TOP)/../terraform

export PATH := $(TF_PATH)/bin/$(UNAME)_$(ARCH):$(PATH)

ANSIBLE_CMD  = TF_STATE=$(TF_PATH)/$(env) ansible --private-key=../keys/id_syzygy_stat -i ./inventory
PLAYBOOK_CMD = TF_STATE=$(TF_PATH)/$(env) ansible-playbook --private-key=../keys/id_syzygy_stat -i ./inventory

setup:
	@echo "Installing external Ansible roles"
	/bin/bash scripts/role_update.sh

check-env:
ifndef env
	$(error environment is not defined [env=])
endif


ansible/setup: check-env
	$(ANSIBLE_CMD) -m setup all

hub/init: check-env
	$(PLAYBOOK_CMD) --limit hubs plays/init.yml

mark/init: check-env
	$(PLAYBOOK_CMD) --limit markers plays/init.yml
	
mds/init: check-env
	$(PLAYBOOK_CMD) --limit mdss plays/init.yml

hub/apply: check-env
	$(PLAYBOOK_CMD) --limit hubs plays/hub.yml

mark/apply: check-env
	$(PLAYBOOK_CMD) --limit markers plays/hub.yml

mds/apply: check-env
	$(PLAYBOOK_CMD) --limit mdss plays/hub.yml
