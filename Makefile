BIN_DIRECTORY=bin
EXE_NAME=slct
INSTALL_DIRECTORY=/usr/bin

# Ensure that the output directory exists
dummy := $(shell test -d $(BIN_DIRECTORY) || mkdir -p $(BIN_DIRECTORY))

compile: $(BIN_DIRECTORY)/$(EXE_NAME)
$(BIN_DIRECTORY)/$(EXE_NAME): slct.c
	gcc -o $(BIN_DIRECTORY)/$(EXE_NAME) -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 slct.c

install: compile $(INSTALL_DIRECTORY)/$(EXE_NAME)
$(INSTALL_DIRECTORY)/$(EXE_NAME):
	install --group=root --owner=root $(BIN_DIRECTORY)/$(EXE_NAME) $(INSTALL_DIRECTORY)

uninstall:
	rm $(INSTALL_DIRECTORY)/$(EXE_NAME)

clean:
	rm -rf $(BIN_DIRECTORY)
