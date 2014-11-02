/* This is the scanner definitiions and rules for project 3 
 *
 * string is greedy and grabs all characers between double quotes that isn't a newline
 *
 * word comes last in the rules so it doesn't grab a string or keyword
 * 		
 * The finished version needs to look something like this:
%{
#include <cstdlib.h>
#include "y.tab.h"
%}
same definitions
%%
{keyword}	{strncpy(yylval.str_val, yytext, yyleng); return KEYWORD;}
{variable}	{strncpy(yylval.str_val, yytext, yyleng); return VARIABLE;}
{string}	{strncpy(yylval.str_val, yytext, yyleng); return STRING;}
{metacharacter}	{yylval.int_token = atoi(yytext); return METACHARACTER;}
{word}		{strncpy(yylval.str_val, yytext, yyleng); return WORD;}
%%

main function defined somewhere at some point
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
%%

{keyword}	printf("Found the keyword %s!", yytext);
{variable}	printf("Found the variable %s!", yytext);
{string}	printf("Found the string %s!", yytext);
{metacharacter}	printf("Found the metacharacter %s!", yytext);
{word}		printf("Found the word %s!", yytext);
%%

void yyerror(char* str) {printf("Parse Error: \n%s\n",str);}
int yywrap(void){}

