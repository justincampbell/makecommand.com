BIN := bin

default: build

include Makefile.hugo

build: $(HUGO)
	$(HUGO)

clean:
	rm -rf $(BIN) $(TMPDIR)

$(BIN):
	mkdir -p $@

.PHONY: default build clean
