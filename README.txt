CS485 Programming Assignment #3

GROUP:
Shannon Simpson
Bryan Potere
Bhushan Chitre
Michael Carlton

INCLUDED FILES
README.txt		This file.
makefile		'make' creates svsh, which calls the scanner/parser.
project3.lex		Contains the rules and definitions of the scanner.
testfile		Just some sample possible lines to feed the scanner.
project3.y		Should contain the grammar rules and token definitions.
			Right now the parser recognizes some any text lines.
main.c			Calls yyparse(), the parser. Includes system table declarations.
functions.h		Libraries to include and inital declaration of Sharing Variable Functions.
mytable.h		Libraries to include and inital declaration of table variables and functions.
p3syscalls.c		Functions definitions for Shared Variables. 
structs.h		Libraries and initial declarations of structs.

EXECUTABLES:
svsh			./svsh will run the shell.
			./svsh < _filename__  will run with one of the test files.

Not to be turned in, but used for testing:
test1			File that contains commands with variable declarations 
				as well as "bye" to close the shell.
test2			File that contains commands with "cd" declarations 
				as well as "bye" to close the shell.
test3			File that contains commands with run declarations 
				as well as "bye" to close the shell.
testfile		File that contains commands with different typed declarations,
				some that are correct, some that will produce a parser 
				error as well as "bye" to close the shell.
testfile2		File that combines test1, test2, and test3 files to test on a 
				larger scale, as well as a "bye" to close the shell.

