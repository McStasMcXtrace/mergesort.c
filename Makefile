TEST = test.c mergesort.c
EXAMPLE = example.c mergesort.c
OBJ_TEST = $(TEST:.c=.o)
OBJ_EXAMPLE = $(EXAMPLE:.c=.o)
CC = pgcc

CFLAGS = -D_GNU_SOURCE

LFLAGS =

COVFLAGS = -Wall -fprofile-arcs -ftest-coverage

test: $(OBJ_TEST)
	$(CC) $(OBJ_TEST) -o $@

example: $(OBJ_EXAMPLE)
	$(CC) $(OBJ_EXAMPLE) -o $@

coverage: $(OBJ_TEST)
	($CC) $(COVFLAGS) $(TEST) -o $@

.SUFFIXES: .c .o
.c.o:
	$(CC) $< $(CFLAGS) $(LFLAGS) -c -o $@

run-coverage: coverage
	./coverage && gcov mergesort

run-test: test
	./test

run-example: example
	./example

clean:
	rm -f coverage test example $(OBJ_TEST) $(OBJ_EXAMPLE) *.gc{ov,da,no}

.PHONY: clean run-coverage run-test
