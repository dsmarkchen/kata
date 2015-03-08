all: doc
	ctangle kata.w
	gcc -Wall -Wextra -pedantic-errors   kata.c
doc:
	cweave kata.w
	tex kata.tex

clean:
	rm -rf kata.o kata.c kata.tex a.out kata.dvi
