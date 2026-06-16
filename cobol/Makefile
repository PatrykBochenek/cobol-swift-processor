COBC ?= cobc
COBC_FLAGS ?= -x -free
COBC_MODULE_FLAGS ?= -m -free
SRC_DIR := src
BIN_DIR := bin
SOURCES := $(wildcard $(SRC_DIR)/*.cob)
IBAN_CHECK_SRC := $(SRC_DIR)/IBAN-CHECK.cob
IBAN_HARNESS_SRC := $(SRC_DIR)/IBAN-CHECK-HARNESS.cob
PROGRAM_SOURCES := $(filter-out $(IBAN_CHECK_SRC) $(IBAN_HARNESS_SRC),$(SOURCES))

.PHONY: all build clean

all: build

build:
	@mkdir -p $(BIN_DIR)
ifeq ($(strip $(SOURCES)),)
	@echo "No COBOL sources found in $(SRC_DIR). Nothing to compile."
else
	@set -e; \
	if [ -f "$(IBAN_CHECK_SRC)" ]; then \
		echo "Compiling module $(IBAN_CHECK_SRC) -> $(BIN_DIR)/IBAN-CHECK.so"; \
		$(COBC) $(COBC_MODULE_FLAGS) -o "$(BIN_DIR)/IBAN-CHECK.so" "$(IBAN_CHECK_SRC)"; \
	fi; \
	if [ -f "$(IBAN_HARNESS_SRC)" ] && [ -f "$(IBAN_CHECK_SRC)" ]; then \
		echo "Compiling harness $(IBAN_HARNESS_SRC) -> $(BIN_DIR)/IBAN-CHECK-HARNESS"; \
		$(COBC) $(COBC_FLAGS) -o "$(BIN_DIR)/IBAN-CHECK-HARNESS" "$(IBAN_HARNESS_SRC)" "$(IBAN_CHECK_SRC)"; \
	fi; \
	for src in $(PROGRAM_SOURCES); do \
		base=$$(basename "$$src" .cob); \
		echo "Compiling $$src -> $(BIN_DIR)/$$base"; \
		$(COBC) $(COBC_FLAGS) -o "$(BIN_DIR)/$$base" "$$src"; \
	done
endif

clean:
	@rm -rf $(BIN_DIR)
	@echo "Cleaned $(BIN_DIR)"
