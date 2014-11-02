/* BISON file
 * Contains the grammar for our svsh parser
 * Also defines the tokens that the scanner will look for
 *
 */

%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern void yyerror(char*);
%}

%union{
    int int_token;
    char* str_val;
}
	
%token <int_token> METACHARACTER
%token <str_val> KEYWORD VARIABLE STRING WORD

%start parsetree
%%

parsetree:	lines;
lines:		lines anytext | anytext;

anytext:	WORD
		| KEYWORD
		| STRING
		| VARIABLE
		| METACHARACTER {printf("Parsed a line of any text");};
%%
