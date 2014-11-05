/* Project 3
 * This is the .lex file which describes a scanner that flex will construct	
 * The finished version shouldn't print stuff everywhere 
 * 
 * The stuff in %{ %} gets pasted right into the .c file:
%{
#include <cstdlib.h>
#include "y.tab.h"
%}
definitions
%%
rules
%%

main function defined in the main.c file

using only one keyword was getting too confusing in the .y file
keyword		"defprompt"|"cd"|"listjobs"|"bye"|"run"|"assignto"|"<bg>"
{keyword}	{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Scanner found keyword: %s!", yytext); 
		return KEYWORD;}

 */

%{
#include <stdlib.h>
#include "project3.tab.h"
void yyerror(char*);
%}

digit		[0-9]
alpha		[a-zA-Z]
defprompt	"defprompt"
cd		"cd"
listjobs	"listjobs"
bye		"bye"
run		"run"
assignto	"assignto"
bg		"<bg>"
variable	$([0-9A-Za-z\S_])*
string 		\"[^\"\r\n]*\"
metacharacter	"#"|"="
word		([^\r\n \t#])*
newline		"\n"|"\r"
%%

{newline}	{printf("Scanner found a newline character!\n");
		return 0;}		
{defprompt}	{printf("Scanner found defprompt!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{cd}		{printf("Scanner found cd!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{listjobs} 	{printf("Scanner found listjobs!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{bye} 		{printf("Scanner found bye!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{run}		{printf("Scanner found run!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{assignto}	{printf("Scanner found assignto!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{bg}		{printf("Scanner found <bg>!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{variable}	{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Scanner found variable: %s!\n", yytext); 
		return VARIABLE;}
{string}	{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Scanner found string: %s!\n", yytext); 
		return STRING;}
{metacharacter}	{yylval.int_token = *(yytext); 
		printf("Scanner found the metacharacter: %s!\n", yytext); 
		return METACHARACTER;}
{word}		{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Scanner found the word: %s!\n", yytext); 
		return WORD;}
%%

void yyerror(char* str) {printf("Parse Error: \n%s\n",str);}
int yywrap(void){}

