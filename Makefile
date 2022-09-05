.PHONY: help all remove test scripts aliases script_notice alias_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))
aliases := $(subst aliases/,,$(wildcard aliases/*))

help:
	@echo "Possible choices are:"
	@echo -ne "\e[1;31m"
	@echo -ne "$(shell echo "all $(scripts) $(aliases)" | tr ' ' '\n' | nl | tr '\t' ' ')"
	@echo -e "\e[0m"

all: $(scripts) $(aliases) script_notice alias_notice

$(scripts):
	mkdir --parents ~/.local/bin/
	cp scripts/$@ ~/.local/bin/

script_notice:
	@echo -ne "\033[1;32m"
	@echo -ne "Make sure '$(HOME)/.local/bin' is in your PATH"
	@echo -e "\033[0m"

$(aliases):
	mkdir --parents ~/.bash_helpers
	cp aliases/$@ ~/.bash_helpers

alias_notice:
	@echo -ne "\033[1;32m"
	@echo -ne "Make sure '$(HOME)/.bash_helpers/*' is sourced in your .bashrc"
	@echo -e "\033[0m"

remove:
	rm --recursive --force ~/.bash_helpers

test:
	shellcheck $(wildcard scripts/*) $(wildcard aliases/*)
