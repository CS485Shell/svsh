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
 */

%{
#include <stdlib.h>
#include "project3.tab.h"
void yyerror(char*);
%}

digit		[0-9]
alpha		[a-zA-Z]
keyword		"defprompt"|"cd"|"listjobs"|"bye"|"run"|"assignto"|"<bg>"
variable	$([0-9A-Za-z\S_])*
string 		\"[^\"\r\n]*\"
metacharacter	"#"|"="
word		([^\r\n \t#])*
newline		"\n"|"\r"
%%

{newline}	{printf("Found a newline character!");
		return 0;}		

{keyword}	{yylval.str_val = (char*) malloc(yyleng+1); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Found keyword: %s!", yytext); 
		return KEYWORD;}
{variable}	{yylval.str_val = (char*) malloc(yyleng+1); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Found variable: %s!", yytext); 
		return VARIABLE;}
{string}	{yylval.str_val = (char*) malloc(yyleng+1); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Found string: %s!", yytext); 
		return STRING;}
{metacharacter}	{yylval.int_token = *(yytext); 
		printf("Found the metacharacter: %s!", yytext); 
		return METACHARACTER;}
{word}		{yylval.str_val = (char*) malloc(yyleng+1); 
		strncpy(yylval.str_val, yytext, yyleng); 
		printf("Found the word: %s!", yytext); 
		return WORD;}
%%

void yyerror(char* str) {printf("Parse Error: \n%s\n",str);}
int yywrap(void){}

