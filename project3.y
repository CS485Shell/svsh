/* BISON file
 * Contains the grammar for our svsh parser
 * Also defines the tokens that the scanner will look for
 *
 */

%{
#include "functions.h"
#include "mytable.h"
void printTokens();
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
		  
		      if(Showtokens)printTokens();
		  }
		  input_argc = 1;
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
		  //if(Showtokens)printf("Usage = bye\n");
		  sym_table = putsym(BYE, $1, "bye");
		  if(Showtokens)printTokens();
		  exit(0);}
		|LISTJOBS
		 {if(Debug)printf("Parser got: %s\n", $1);
		  //if(Showtokens)printf("Usage = listjobs\n");
		  sym_table = putsym(LISTJOBS, $1, "listjobs");
		  if(Showtokens)printTokens();
		  input_argc = 1;
		 }
		|DEFPROMPT STRING
		 {if(Debug)printf("Parser got: %s should be %s\n", $1, $2);
		  //if(Showtokens)printf("Usage = defprompt\n");
		  sym_table = putsym(DEFPROMPT, $1, "defprompt");
		  sym_table = putsym(STRING, $2, "prompt");
		  if(Showtokens)printTokens();
  		  strncpy(prompt, $2, MAXSTRINGLENGTH);
		  input_argc = 1;
		 }
		|CD WORD
		 {if(Debug)printf("Parser got: %s to %s\n", $1, $2); 
		  //if(Showtokens)printf("Usage = cd\n"); 
		  sym_table = putsym(CD, $1, "cd");
		  sym_table = putsym(WORD, $2, "directory_name");
		  if(Showtokens)printTokens();
		  input_argc = 1;
		 }
		|CD VARIABLE
		 {if(Debug)printf("Parser got: %s to %s\n", $1, $2); 
		  //if(Showtokens)printf("Usage = cd\n");
		  sym_table = putsym(CD, $1, "cd");
		  sym_table = putsym(CD, $2, "directory_name");
		  if(Showtokens)printTokens();
		  input_argc = 1;
		 }
		|VARIABLE METACHARACTER STRING
		 {if(Debug)printf("Parser got: %s %c %s\n", $1, $2, $3);
		  //if(Showtokens)printf("Usage = variable_name\n");
		  if($2 == 61){
		    sym_table = putsym(VARIABLE, $1, "variable");
		    //char *temp = &$2;
		    sym_table = putsym(METACHARACTER, "=", "assignment");
		    sym_table = putsym(STRING, $3, "variable_def");
		    if(Showtokens)printTokens();

		  }
		  else{
			yyerror("syntax assignment error");
		  }
		    input_argc = 1;
		 }
		|ASSIGNTO VARIABLE filename arg_list
		 {if(Debug)printf("Parser got an assignto line\n");
		  //if(Showtokens)printf("Usage = assignto\n");
		  sym_table = pushsym(VARIABLE, $2, "variable");
		  sym_table = pushsym(ASSIGNTO, $1, "assignto");
		  if(Showtokens)printTokens();
		  input_argc = 1;
		 }
		|run
		;

run:		RUN filename
		 {if(Debug)printf("Parser saw a run without arguments, BG option\n");
		  //if(Showtokens)printf("Usage = run\n");
		  input_argc = 1;
		 }
		|RUN filename BG
		 {if(Debug)printf("Parser saw a run with BG option, no arguments\n");
		  input_argc = 1;
		 }
		|RUN filename arg_list
		 {if(Debug)printf("Parser saw a run without BG option\n");
		  input_argc = 1;
		 }
		|RUN filename arg_list BG
		 {if(Debug)printf("Parser saw a run with a BG option\n");
		  input_argc = 1;
		 }
		;
filename:	WORD
		{//if(Showtokens)printf("Usage = filename\n");
		 sym_table = putsym(WORD, $1, "directory_name");
		}	
		;

arg_list:	arg_list argument 
		|argument
		;

argument:	WORD 
		{//if(Showtokens)printf("Usage = arg %d\n", input_argc++);
		 sym_table = putsym(WORD, $1, "arg");
		}
		|STRING
		{//if(Showtokens)printf("Usage = arg %d\n", input_argc++);
		 sym_table = putsym(STRING, $1, "arg");
		} 
		|VARIABLE
		{//if(Showtokens)printf("Usage = arg %d\n", input_argc++);
		 sym_table = putsym(VARIABLE, $1, "arg");
		}
		;
		
%%

//Prints all the symbols seen in order
void printTokens(){

	symrec* ptr;
	ptr = sym_table;
	while(ptr != NULL){	
	  if(ptr->type == METACHARACTER)printf("Token Type = metachar\t");
	  else if(ptr->type == DEFPROMPT)printf("Token Type = keyword\t");
	  else if(ptr->type == CD)printf("Token Type = keyword\t");
	  else if(ptr->type == LISTJOBS)printf("Token Type = keyword\t");
	  else if(ptr->type == BYE)printf("Token Type = keyword\t");
	  else if(ptr->type == RUN)printf("Token Type = keyword\t");
	  else if(ptr->type == ASSIGNTO)printf("Token Type = keyword\t");
	  else if(ptr->type == BG)printf("Token Type = keyword\t");
	  else if(ptr->type == VARIABLE)printf("Token Type = variable\t");
	  else if(ptr->type == STRING)printf("Token Type = string\t");
	  else if(ptr->type == WORD)printf("Token Type = word\t");
	  printf("Token = %s\t\tUsage = %s\n",
		ptr->value, ptr->usage);
	  ptr = ptr->next;
	}
}
