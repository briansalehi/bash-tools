.PHONY: help all remove test scripts script_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))
aliases := $(subst aliases/,,$(wildcard aliases/*))

help:
	@tput setaf 2
	@tput bold
	@echo "Available targets:"
	@echo
	@tput setaf 3
	@echo all $(scripts) $(aliases) | tr ' ' '\n' | nl | tr -s ' ' | tr '\t' ' ' | column
	@tput sgr0
	@echo
	@tput setaf 6
	@tput bold
	@echo "make <target>"
	@tput sgr0
	@echo

all: $(scripts) $(aliases) script_notice alias_notice

$(scripts): script_notice
	mkdir --parents $(HOME)/.local/bin
	cp scripts/$@ $(HOME)/.local/bin

cmake-maintenance: script_notice
	mkdir --parents $(HOME)/.local/bin
	mkdir --parents $(HOME)/.config/systemd/user
	cp services/$@ $(HOME)/.local/bin
	cp systemd/cmake-maintenance.timer $(HOME)/.config/systemd/user/
	cp systemd/cmake-maintenance.service $(HOME)/.config/systemd/user/

node-maintenance: script_notice
	mkdir --parents $(HOME)/.local/bin
	mkdir --parents $(HOME)/.config/systemd/user
	cp services/$@ $(HOME)/.local/bin
	cp systemd/node-maintenance.timer $(HOME)/.config/systemd/user/
	cp systemd/node-maintenance.service $(HOME)/.config/systemd/user/

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

test:
	shellcheck $(wildcard scripts/*) $(wildcard aliases/*)
