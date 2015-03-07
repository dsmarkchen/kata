all:
	ctangle kata.w
	cweave kata.w
	gcc -Wall -Wextra -pedantic-errors   kata.c
clean:
	rm -rf kata.o kata.c kata.tex a.out
