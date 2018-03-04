###
### Makefile
###

PREFIX ?= /usr/local
GITPREFIX ?= /usr/local
TOOLS  = tools

.PHONY: all build install test uninstall

all: build

build:
	@cd $(TOOLS) && ./build.sh $(PREFIX) $(GITPREFIX)

install:
	@cd $(TOOLS) && ./install.sh $(PREFIX) $(GITPREFIX)

test:
	@cd $(TOOLS) && ./test.sh $(PREFIX) $(GITPREFIX)

uninstall:
	@cd $(TOOLS) && ./uninstall.sh $(PREFIX) $(GITPREFIX)
