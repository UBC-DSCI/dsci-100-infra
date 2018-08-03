UNAME := $(shell uname | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)
TOP := $(shell pwd)
TF_PATH := $(TOP)/../terraform

export PATH := $(TF_PATH)/bin/$(UNAME)_$(ARCH):$(PATH)

ANSIBLE_CMD  = TF_STATE=$(TF_PATH)/$(env) ansible --private-key=../keys/id_syzygy_stat -i ./bin/ansible-terraform-inventory-$(UNAME)-$(ARCH)
PLAYBOOK_CMD = TF_STATE=$(TF_PATH)/$(env) ansible-playbook --private-key=../keys/id_syzygy_stat -i ./bin/ansible-terraform-inventory-$(UNAME)-$(ARCH)

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
	$(PLAYBOOK_CMD) plays/init.yml

hub/apply: check-env
	$(PLAYBOOK_CMD) --limit hub plays/hub.yml
