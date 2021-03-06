###
### Makefile
###

PREFIX ?= /usr/local
GITPREFIX ?= /usr
TOOLS  = tools

.PHONY: all build install test uninstall

all: build

build:
	@cd $(TOOLS) && ./build.sh $(GITPREFIX)

install:
	@cd $(TOOLS) && ./install.sh $(PREFIX)

test:
	@cd $(TOOLS) && ./test.sh $(PREFIX)

uninstall:
	@cd $(TOOLS) && ./uninstall.sh $(PREFIX)
