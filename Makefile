# Default directories and tools
BUILD_DIR ?= build
CONTENT_DIRS ?= auto clothing devices food social
TEMPLATE ?= tmpl.html
STYLESHEET ?= styles.css
PANDOC ?= pandoc

MD_SOURCES := $(shell find $(CONTENT_DIRS) -name '*.md' -print)
HTML_OUTPUTS := $(patsubst %.md,$(BUILD_DIR)/%.html,$(MD_SOURCES))

PANDOC_FLAGS := --standalone --template=$(TEMPLATE) --css $(STYLESHEET)

.PHONY: all build clean list

all: build

build: $(HTML_OUTPUTS)

$(BUILD_DIR)/%.html: %.md $(TEMPLATE) $(STYLESHEET)
	@mkdir -p $(dir $@)
	$(PANDOC) $< $(PANDOC_FLAGS) --output $@

clean:
	rm -rf $(BUILD_DIR)

list:
	@printf '%s\n' $(MD_SOURCES)
