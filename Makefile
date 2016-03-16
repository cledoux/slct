PREFIX ?= /usr/local
BUILD_DIRECTORY=build
EXE_NAME=slct

# Ensure that the output directory exists
dummy := $(shell test -d $(BUILD_DIRECTORY)/bin || mkdir -p $(BUILD_DIRECTORY)/bin)

build: compile man

compile: $(BUILD_DIRECTORY)/bin/$(EXE_NAME)
$(BUILD_DIRECTORY)/bin/$(EXE_NAME): slct.c
	gcc -o $(BUILD_DIRECTORY)/bin/$(EXE_NAME) -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 slct.c

man: $(BUILD_DIRECTORY)/man/man1/slct.1.gz
$(BUILD_DIRECTORY)/man/man1/slct.1.gz: slct.1
	mkdir -p $(BUILD_DIRECTORY)/man/man1
	install -m 0644 slct.1 $(BUILD_DIRECTORY)/man/man1/
	gzip $(BUILD_DIRECTORY)/man/man1/slct.1

install: build $(PREFIX)/bin/$(EXE_NAME)
$(PREFIX)/bin/$(EXE_NAME):
	mkdir -p $(PREFIX)/bin $(PREFIX)/man/man1
	install $(BUILD_DIRECTORY)/bin/$(EXE_NAME) $(PREFIX)/bin/$(EXE_NAME)
	install $(BUILD_DIRECTORY)/man/man1/slct.1.gz $(PREFIX)/man/man1/slct.1.gz

uninstall:
	rm $(PREFIX)/bin/$(EXE_NAME)
	rm $(PREFIX)/man/man1/slct.1.gz

clean:
	rm -rf $(BUILD_DIRECTORY)
