NOTES
11/13/14
	The project.y makeArgList() function finally makes the argument list correctly, where the first element should always be the filename and the arguments are in input order.  There is also a companion variable that tracks how many arguments there are.  The parser is ready to call functions to actually perform the user's command.  

How it works: The main function contains the symbol table definition and pushsym, putsym, and free_table functions.  The symbol table is a linked list of structs where each struct has the token type (an int representing metacharacter, keyword, etc.), value, and usage.

	I removed the Debug global variable.  There are debug definitions in project3.y and project3.lex for debugging now.

INCLUDED FILES

makefile		'make' creates svsh, which calls the scanner/parser.
project3.lex		Contains the rules and definitions of the scanner.
testfile		Just some sample possible lines to feed the scanner.
project3.y		Should contain the grammar rules and token definitions.
			Right now the parser recognizes some any text lines.
main.c			Calls yyparse(), the parser.
