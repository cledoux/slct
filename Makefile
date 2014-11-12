BIN_DIRECTORY=bin
EXE_NAME=slct
INSTALL_DIRECTORY=/usr/local/bin

# Ensure that the output directory exists
dummy := $(shell test -d $(BIN_DIRECTORY) || mkdir -p $(BIN_DIRECTORY))

compile: $(BIN_DIRECTORY)/$(EXE_NAME)
$(BIN_DIRECTORY)/$(EXE_NAME): slct.c
	gcc -o $(BIN_DIRECTORY)/$(EXE_NAME) -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 slct.c

install: compile man $(INSTALL_DIRECTORY)/$(EXE_NAME)
$(INSTALL_DIRECTORY)/$(EXE_NAME):
	install --group=root --owner=root $(BIN_DIRECTORY)/$(EXE_NAME) $(INSTALL_DIRECTORY)

man: /usr/local/man/man1/slct.1.gz
/usr/local/man/man1/slct.1.gz: slct.1
	install -g 0 -o 0 -m 0644 slct.1 /usr/local/man/man1/
	gzip /usr/local/man/man1/slct.1

uninstall:
	rm $(INSTALL_DIRECTORY)/$(EXE_NAME)
	rm /usr/local/man/man1/slct.1.gz

clean:
	rm -rf $(BIN_DIRECTORY)
