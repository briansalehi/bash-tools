.PHONY: setup remove

scripts := $(wildcard scripts/*)

setup: $(scripts)
	mkdir --parents ~/.bash_helpers
	cp $^ ~/.bash_helpers

remove:
	rm --recursive --force ~/.bash_helpers

