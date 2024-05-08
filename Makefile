.PHONY: help all remove test scripts script_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))
aliases := $(subst aliases/,,$(wildcard aliases/*))

help:
	@echo "Possible choices are:"
	@echo -e "\e[1;33m" # colorize items
	@echo all $(scripts) $(aliases) | tr ' ' '\n' | nl | tr -s ' ' | tr '\t' ' ' | column
	@echo -e "\e[0m" # reset coloring

all: $(scripts) $(aliases) script_notice alias_notice

$(scripts): script_notice
	mkdir --parents $(HOME)/.local/bin
	cp scripts/$@ $(HOME)/.local/bin

$(aliases): alias_notice
	mkdir --parents $(HOME)/.bash_tools
	cp aliases/$@ $(HOME)/.bash_tools

script_notice:
	@echo -e "\033[1;33mUse 'aliases/include_path' utility to add '$$HOME/.local/bin' to your PATH:"
	@echo -e "\033[1;35m"
	@echo -e "\t"'include_path $$HOME/.local/bin'
	@echo -e "\033[0m"

alias_notice:
	@echo -e "\033[1;33mAdd following line in your '$$HOME/.bashrc' file:"
	@echo -e "\033[1;35m"
	@echo -e "\t"'for tool in $$HOME/.bash_tools/*; do source $$tool; done'
	@echo -e "\033[0m"

test:
	shellcheck $(wildcard scripts/*) $(wildcard aliases/*)
