INCLUDED FILES

makefile		'make' creates svsh, which calls the scanner/parser.
project3.lex		Contains the rules and definitions of the scanner.
testfile		Just some sample possible lines to feed the scanner.
project3.y		Should contain the grammar rules and token definitions.
			Right now the parser recognizes some any text lines.
main.c			Calls yylex(), the scanner, then yyparse(), the parser.	
