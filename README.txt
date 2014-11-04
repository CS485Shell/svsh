NOTES
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
main.c			Calls yylex(), the scanner, then yyparse(), the parser.	
