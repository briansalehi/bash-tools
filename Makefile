.PHONY: setup remove test scripts aliases

script_files := $(wildcard scripts/*)
alias_files := $(wildcard aliases/*)

setup: scripts aliases

scripts: $(script_files)
	mkdir --parents ~/.local/bin/
	cp $^ ~/.local/bin/
	@echo "Make sure '$$HOME/.local/bin' is in your PATH"

aliases: $(alias_files)
	mkdir --parents ~/.bash_helpers
	cp $^ ~/.bash_helpers
	@echo "Make sure '$$HOME/.bash_helpers' is sourced"

remove:
	rm --recursive --force ~/.bash_helpers

test:
	shellcheck $(script_files)
