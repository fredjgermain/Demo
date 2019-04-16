CC = gcc 
CC2 = gcc -W -Wall -lm
BIN = bin/
SRC = src/
INC = src/includes/
INCS = util list path inode memory folder cmd

DEPlist :=
DEPcmd := 
DEPinode := 
DEPfolder := 
DEPmem :=
DEPpath :=


run: includes build exe

test:
	$(CC) $(BIN)*.o -o testfs $(SRC)testfs.c
	./testfs cmd.txt

build:
	$(CC) $(BIN)*.o -o fs $(SRC)fs.c

exe:
	./fs cmd.txt
    
includes: $(INCS)

$(INCS): $(DEP$@)
	$(CC) -o $(BIN)$@.o -c $(INC)$@.c

clean:
	rm -f $(BIN)*.o
	rm -f *.exe