/* BISON file
 * Contains the grammar for our svsh parser
 * Also defines the tokens that the scanner will look for
 *
 */

%{
#include "functions.h"
extern char prompt[];
extern int yylex();
extern void yyerror(char*);
%}

%union{
    char int_token;
    char* str_val;
}
	
%token <int_token> METACHARACTER
%token <str_val> DEFPROMPT CD LISTJOBS BYE RUN ASSIGNTO BG VARIABLE STRING WORD

%start parsetree
%%

parsetree:	line;
line:		comment | run_command;

comment:	METACHARACTER anytext
		 {if($1 == 35)printf("Found a comment: %d\n", $1);}; 
anytext:	anytext WORD | WORD
		| anytext DEFPROMPT | DEFPROMPT
		| anytext CD | CD
		| anytext LISTJOBS | LISTJOBS
		| anytext BYE | BYE
		| anytext RUN | RUN
		| anytext ASSIGNTO | ASSIGNTO
		| anytext BG | BG
		| anytext STRING | STRING
		| anytext VARIABLE | VARIABLE
		| anytext METACHARACTER | METACHARACTER
		;

run_command:	LISTJOBS
		 {printf("Parser got: %s\n", $1);}
		|DEFPROMPT STRING
		 {printf("Parser got: %s should be %s\n", $1, $2);}
		|CD WORD
		 {printf("Parser got: %s to %s\n", $1, $2);}
		|run
		;

run:		RUN filename arg_list
		| RUN filename arg_list BG
		;
filename:	WORD;
arg_list:	arg_list argument | argument;
argument:	WORD | STRING | VARIABLE;
		
%%
