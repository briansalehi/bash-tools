.PHONY: help all remove test scripts script_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))

help:
	@echo "Possible choices are:"
	@echo -ne "\e[1;31m"
	@echo -ne "$(shell echo "all $(scripts)" | tr ' ' '\n' | nl | tr '\t' ' ')"
	@echo -e "\e[0m"

all: $(scripts) script_notice

$(scripts):
	mkdir --parents ~/.bash_tools
	cp scripts/$@ ~/.bash_tools

script_notice:
	@echo -ne "\033[1;32m"
	@echo -ne "Make sure '$(HOME)/.bash_tools' is sourced in your ~/.bashrc file"
	@echo -e "\033[0m"

remove:
	rm --recursive --force ~/.bash_tools

test:
	shellcheck $(wildcard scripts/*)
