.PHONY: help all remove test scripts aliases services script_notice service_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))
aliases := $(subst aliases/,,$(wildcard aliases/*))
services := $(subst services/,,$(wildcard services/*))

help:
	@tput setaf 2
	@tput bold
	@echo "Available targets:"
	@echo
	@tput setaf 3
	@echo all $(scripts) $(aliases) $(services) | tr ' ' '\n' | nl | tr -s ' ' | tr '\t' ' ' | column
	@tput sgr0
	@echo
	@tput setaf 6
	@tput bold
	@echo "make <target>"
	@tput sgr0
	@echo

all: $(scripts) $(aliases) $(services) script_notice alias_notice

$(scripts): script_notice
	mkdir --parents $(HOME)/.local/bin
	cp scripts/$@ $(HOME)/.local/bin

services: $(services)

$(services): service_notice
	mkdir --parents $(HOME)/.local/bin
	cp services/$@ $(HOME)/.local/bin
	sudo cp services/$@ /usr/local/bin
	sudo cp systemd/$@.timer /usr/lib/systemd/system/
	sudo cp systemd/$@.service /usr/lib/systemd/system/

$(aliases): alias_notice
	mkdir --parents $(HOME)/.bash_tools
	cp aliases/$@ $(HOME)/.bash_tools

script_notice:
	@tput setaf 3
	@tput bold
	@echo 'Use `include_path` utility to add `$$HOME/.local/bin` to your PATH:'
	@echo
	@tput setaf 6
	@echo 'include_path $$HOME/.local/bin'
	@tput sgr0
	@echo

alias_notice:
	@tput setaf 3
	@tput bold
	@echo 'Add following line in your `$$HOME/.bashrc` file:'
	@echo
	@tput setaf 6
	@echo 'for tool in $$HOME/.bash_tools/*; do source $$tool; done'
	@tput sgr0
	@echo

service_notice:
	@tput setaf 3
	@tput bold
	@echo 'Reload systemd configuration and enable your services:'
	@echo
	@tput setaf 6
	@echo 'sudo systemctl daemon-reload'
	@echo 'sudo systemctl enable --now <service>'
	@tput sgr0
	@echo

test:
	shellcheck $(wildcard scripts/*) $(wildcard aliases/*) $(wildcard services/*)
