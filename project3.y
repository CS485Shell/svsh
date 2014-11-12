/* BISON file
 * Contains the grammar for our svsh parser
 * Also defines the tokens that the scanner will look for
 *
 */

%{
#include "functions.h"
extern char* prompt;
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
		 {if($1 == 35){
		      if(Debug)printf("Found a comment: %d\n", $1);
		  
		      if(Showtokens)printf("Token usage = comment");
		  }
		 }; 
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

run_command:	BYE
		 {if(Debug)printf("Parser got: %s\n", $1);
		  if(Showtokens)printf("Usage = cmd\n");
		  exit(0);}
		|LISTJOBS
		 {if(Debug)printf("Parser got: %s\n", $1);
		  if(Showtokens)printf("Usage = cmd\n");
		 }
		|DEFPROMPT STRING
		 {if(Debug)printf("Parser got: %s should be %s\n", $1, $2);
		  if(Showtokens)printf("Usage = cmd\n");
		    strncpy(prompt, $2, MAXSTRINGLENGTH);
		 }
		|CD WORD
		 {if(Debug)printf("Parser got: %s to %s\n", $1, $2); 
		  if(Showtokens)printf("Usage = cmd\n");
		 }
		|CD VARIABLE
		 {if(Debug)printf("Parser got: %s to %s\n", $1, $2); 
		  if(Showtokens)printf("Usage = cmd\n");
		 }
		|VARIABLE METACHARACTER STRING
		 {if(Debug)printf("Parser got: %s %c %s\n", $1, $2, $3);
		  if(Showtokens)printf("Usage = cmd\n");
		 }
		|ASSIGNTO VARIABLE filename arg_list
		 {if(Debug)printf("Parser got an assignto line\n");
		  if(Showtokens)printf("Usage = cmd\n");
		 }
		|run
		;

run:		RUN filename
		 {if(Debug)printf("Parser saw a run without arguments, BG option\n");}
		|RUN filename BG
		 {if(Debug)printf("Parser saw a run with BG option, no arguments\n");}
		|RUN filename arg_list
		 {if(Debug)printf("Parser saw a run without BG option\n");}
		|RUN filename arg_list BG
		 {if(Debug)printf("Parser saw a run with a BG option\n");}
		;
filename:	WORD;
arg_list:	arg_list argument | argument;
argument:	WORD | STRING | VARIABLE;
		
%%
