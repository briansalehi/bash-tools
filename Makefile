.PHONY: help all remove test scripts script_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))
aliases := $(subst aliases/,,$(wildcard aliases/*))

help:
	@echo "Possible choices are:"
	@echo -ne "\e[1;31m"
	@echo -ne "$(shell echo "all $(scripts) $(aliases)" | tr ' ' '\n' | nl | tr '\t' ' ')"
	@echo -e "\e[0m"

all: $(scripts) $(aliases) script_notice

$(scripts):
	mkdir --parents $(HOME)/.local/bin
	cp scripts/$@ $(HOME)/.local/bin

$(aliases):
	mkdir --parents $(HOME)/.bash_tools
	cp aliases/$@ $(HOME)/.bash_tools

script_notice:
	@echo -e "\033[1;33mAdd ~/.local/bin to your PATH:\033[0m"
	@echo 'grep -qv '.local/bin' <<< "$$PATH" && PATH="~/.local/bin:$$PATH"'
	@echo -e "\033[1;33mAdd following line to your ~/.bashrc file:\033[0m"
	@echo 'for tool in ~/.bash_tools/*; do source $$tool; done'

test:
	shellcheck $(wildcard scripts/*) $(wildcard aliases/*)
