COBC ?= cobc
COBC_FLAGS ?= -x -free
SRC_DIR := src
BIN_DIR := bin
SOURCES := $(wildcard $(SRC_DIR)/*.cob)

.PHONY: all build clean

all: build

build:
	@mkdir -p $(BIN_DIR)
ifeq ($(strip $(SOURCES)),)
	@echo "No COBOL sources found in $(SRC_DIR). Nothing to compile."
else
	@set -e; \
	for src in $(SOURCES); do \
		base=$$(basename "$$src" .cob); \
		echo "Compiling $$src -> $(BIN_DIR)/$$base"; \
		$(COBC) $(COBC_FLAGS) -o "$(BIN_DIR)/$$base" "$$src"; \
	done
endif

clean:
	@rm -rf $(BIN_DIR)
	@echo "Cleaned $(BIN_DIR)"
