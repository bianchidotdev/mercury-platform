# close to a copy of https://github.com/azer/go-makefile-example

BUILD := $(shell git rev-parse HEAD)
GITHUB_SHA ?= $(shell git rev-parse HEAD)
VERSION := $(GITHUB_SHA)
PROJECTNAME := $(shell basename "$(PWD)")

GOBASE := $(shell pwd)
GOPATH := $(GOBASE)/vendor:$(GOBASE)
GOBIN := $(GOBASE)/bin
GOFILES := $(wildcard *.go)
LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD)"
BUILDTAGS="-tags=jsoniter"

# Redirect error output to a file, so we can show it in development mode.
STDERR := /tmp/.$(PROJECTNAME)-stderr.txt

# Make is verbose in Linux. Make it silent.
MAKEFLAGS += --silent


## install: Install missing dependencies. Runs `go get` internally. e.g; make install get=github.com/foo/bar
install: go-get

test:
	@$(MAKE) install
	@$(GOBIN)/test

## start: Start in development mode. Auto-starts when code changes.
start:
	@bash -c "trap 'make stop' EXIT; $(MAKE) clean compile start-server run='make clean compile start-server'"

## stop: Stop development mode.
stop: stop-server

start-server: stop-server
	@echo "  >  $(PROJECTNAME) is available"
	@$(GOBIN)/$(PROJECTNAME)

stop-server:
	@echo "Stopping server"

restart-server: stop-server start-server

## compile: Compile the binary.
compile:
	@-touch $(STDERR)
	@-rm $(STDERR)
	@-$(MAKE) -s go-compile 2> $(STDERR)
	@cat $(STDERR) | sed -e '1s/.*/\nError:\n/'  | sed 's/make\[.*/ /' | sed "/^/s/^/     /" 1>&2

## exec: Run given command, wrapped with custom GOPATH. e.g; make exec run="go test ./..."
exec:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) $(run)

## clean: Clean build files. Runs `go clean` internally.
clean:
	@-rm $(GOBIN)/$(PROJECTNAME) 2> /dev/null
	@-$(MAKE) go-clean

go-compile: go-get go-build

go-build:
	@echo "  >  Building binary for $(VERSION)..."
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go build $(BUILDTAGS) $(LDFLAGS) -o $(GOBIN)/$(PROJECTNAME) $(GOFILES)

go-generate:
	@echo "  >  Generating dependency files..."
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go generate $(generate)

go-get:
	@echo "  >  Checking if there is any missing dependencies..."
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go get $(get)

go-install:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go install $(GOFILES)

go-clean:
	@echo "  >  Cleaning build cache"
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go clean

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
