.PHONY: help all remove test scripts script_notice

scripts := $(subst scripts/,,$(wildcard scripts/*))

help:
	@echo "Possible choices are:"
	@echo -ne "\e[1;31m"
	@echo -ne "$(shell echo "all $(scripts)" | tr ' ' '\n' | nl | tr '\t' ' ')"
	@echo -e "\e[0m"

all: $(scripts) script_notice

$(scripts):
	mkdir --parents $(HOME)/.bash_tools
	cp scripts/$@ $(HOME)/.bash_tools

script_notice:
	@echo -e "\n\033[1;33mAppend this line to $(HOME)/.bashrc file:\033[0m"
	@echo -e "\033[1;31m[ -d ~/.bash_tools ] && for tool in ~/.bash_tools/*; do source \$$tool; done\033[0m"

remove:
	rm --recursive --force ~/.bash_tools

test:
	shellcheck $(wildcard scripts/*)
