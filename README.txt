NOTES
11/11/14
	Added a debug and showtokens global variable.  
	Added to the functions.h file prototypes and useful includes.

	The parser now prints out token information in nearly the correct format when Showtokens = 1.

	TODO: The parser needs to build argument lists in the right order as it goes along and correctly print out the usage of each individual token, not just the first token.  It is currently printing the token usage of the first token at the end of the parsed line only.

10/4/14
	The scanner and parser work more closely together than I thought, the parser will just call the scanner each time.  Therefore there isn't any need to call the scanner at any point in the main.c file.
	The parser now recognizes comment lines and the scanner appropriately stops when it encounters a newline character.  The parser appropriately stops when it reads end of file (Ctrl-D).  The parser still prints out an error message and stops completely when it doesn't recognize input.

10/1/14
	The regular expressions for recognizing tokens in the scanner should be correct.  
	It's the grammar that needs work.  Right now if you run it it will print
	out every time it recognizes a token, and the parser occassionally prints
	out that it recognizes a line of any text.

INCLUDED FILES

makefile		'make' creates svsh, which calls the scanner/parser.
project3.lex		Contains the rules and definitions of the scanner.
testfile		Just some sample possible lines to feed the scanner.
project3.y		Should contain the grammar rules and token definitions.
			Right now the parser recognizes some any text lines.
main.c			Calls yyparse(), the parser.
