OBJECTS	= main.o parser.o scanner.o
HEADERS = project3.tab.h functions.h
CC 	= gcc
CFLAGS	= -g

svsh:		$(OBJECTS) $(HEADERS)
		$(CC) $(CFLAGS) $(OBJECTS) -o svsh -lfl

scanner.o:	lex.yy.c
		gcc $(CFLAGS) -c lex.yy.c -o scanner.o

parser.o:	project3.tab.c
		gcc $(CFLAGS) -c project3.tab.c -o parser.o
 
lex.yy.c: 	project3.lex
		flex project3.lex

#The bison -d option also makes the project3.tab.h flie that flex requires
project3.tab.c project3.tab.h:	project3.y
		bison -d project3.y

main.o:		main.c
		gcc -o main.o -c main.c

clean:
	rm -f *.o lex.yy.c project3.tab.c project3.tab.h 
