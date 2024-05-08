.PHONY: help all remove test scripts script_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))
aliases := $(subst aliases/,,$(wildcard aliases/*))

help:
	@echo "Possible choices are:"
	@echo "\e[1;32m" # colorize items
	@echo all $(scripts) $(aliases) | tr ' ' '\n' | nl | tr -s ' ' | tr '\t' ' ' | column
	@echo "\e[0m" # reset coloring

all: $(scripts) $(aliases) script_notice alias_notice

$(scripts): script_notice
	mkdir --parents $(HOME)/.local/bin
	cp scripts/$@ $(HOME)/.local/bin

$(aliases): alias_notice
	mkdir --parents $(HOME)/.bash_tools
	cp aliases/$@ $(HOME)/.bash_tools

script_notice:
	@echo "\033[1;33mUse 'aliases/include_path' utility to add '$$HOME/.local/bin' to your PATH:"
	@echo "\033[1;35m"
	@echo "\t"'include_path $$HOME/.local/bin'
	@echo "\033[0m"

alias_notice:
	@echo "\033[1;33mAdd following line in your '$$HOME/.bashrc' file:"
	@echo "\033[1;35m"
	@echo "\t"'for tool in $$HOME/.bash_tools/*; do source $$tool; done'
	@echo "\033[0m"

test:
	shellcheck $(wildcard scripts/*) $(wildcard aliases/*)
