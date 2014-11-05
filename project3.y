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
    char int_token;
    char* str_val;
}
	
%token <int_token> METACHARACTER
%token <str_val> KEYWORD VARIABLE STRING WORD

%start parsetree
%%

parsetree:	line;
line:		comment | run_command;

comment:	METACHARACTER anytext
			{if($1 == 35)printf("Found a comment: %d", $1);};

anytext:	anytext WORD | WORD
		| anytext KEYWORD | KEYWORD
		| anytext STRING | STRING
		| anytext VARIABLE | VARIABLE
		| anytext METACHARACTER | METACHARACTER
			{printf("Parsed a line of any text");};

run_command:	KEYWORD command arg_list;
command:	WORD;
arg_list:	arg_list argument | argument;
argument:	WORD | STRING | VARIABLE;

%%
