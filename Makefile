.PHONY: setup remove

scripts := $(wildcard scripts/*)

setup: $(scripts)
	mkdir --parents ~/.local/bin/
	cp $^ ~/.local/bin/
	@echo "Make sure "$$HOME/.local/bin" is in your PATH"

remove:
	rm --recursive --force ~/.bash_helpers

