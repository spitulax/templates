PREFIX ?= $(HOME)/.local
BIN_DIR := $(PREFIX)/bin

PROG_VERSION := $(shell cat ./VERSION | tr -d '[:space:]')

SRC_DIR := ./src
BUILD_DIR := ./build
OUT := $(BUILD_DIR)/fooname

ARGS += -collection:src=$(SRC_DIR)
ARGS += -out:$(OUT)
ARGS += -build-mode:exe
ARGS += -vet
ARGS += -disallow-do
ARGS += -warnings-as-errors
ARGS += -use-separate-modules
ARGS += -define:PROG_VERSION=$(PROG_VERSION)

.PHONY: release debug install clean mkdir

debug: mkdir
	odin build $(SRC_DIR) $(ARGS) -debug

release: mkdir
	odin build $(SRC_DIR) $(ARGS) -o:speed

install: release
	install -Dt $(BIN_DIR) $(OUT)

clean: 
	rm -r $(BUILD_DIR)

mkdir:
ifeq ($(wildcard $(BUILD_DIR)/.),)
	mkdir -p $(BUILD_DIR)
endif
