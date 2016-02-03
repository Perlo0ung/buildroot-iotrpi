#  .... find all .c files in the directory .......#
OBJ = $(shell ls *.c)
TARGETS = $(OBJ:.c=)

all:	$(TARGETS)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

# CleanUp .......................................#

clean:
	rm -f *.o $(TARGETS)
