BIN := bin

OS := $(shell go env GOOS)
ARCH := $(shell go env GOARCH)

HUGO_VERSION := 0.14
HUGO_FILENAME := hugo_$(HUGO_VERSION)_$(OS)_$(ARCH)
HUGO := $(BIN)/$(HUGO_FILENAME)

ifeq ($(OS), linux)
  HUGO_PACKAGE_EXTENSION := tar.gz
else
  HUGO_PACKAGE_EXTENSION := zip
endif

HUGO_PACKAGE_FILENAME := $(HUGO_FILENAME).$(HUGO_PACKAGE_EXTENSION)
HUGO_PACKAGE_URL := https://github.com/spf13/hugo/releases/download/v$(HUGO_VERSION)/$(HUGO_PACKAGE_FILENAME)
HUGO_PACKAGE_CACHE := $(TMPDIR)$(HUGO_PACKAGE_FILENAME)

default: build

build: $(HUGO)
	@$(HUGO) version

$(HUGO): $(HUGO_PACKAGE_CACHE) $(BIN)
ifeq ($(OS), linux)
	false
else
	unzip -o $(HUGO_PACKAGE_CACHE) -d $(TMPDIR)
endif
	mv $(TMPDIR)/$(HUGO_FILENAME)/$(HUGO_FILENAME) $(HUGO)
	touch $@

clean:
	rm -rf $(HUGO_PACKAGE_CACHE)

$(BIN):
	mkdir -p $@

$(HUGO_PACKAGE_CACHE):
	wget --output-document $(HUGO_PACKAGE_CACHE) $(HUGO_PACKAGE_URL)

.PHONY: default build clean
