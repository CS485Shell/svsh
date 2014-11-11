/* Project 3
 * This is the .lex file which describes a scanner that flex will construct	
 * Uncomment the printfs to see what gets scanned
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

<<EOF>>		{return BYE;}

{newline}	{printf("Scanner found a newline character!\n");
		return 0;}		
{defprompt}	{printf("Scanner found defprompt!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{cd}		{printf("Scanner found cd!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return CD;}

{listjobs} 	{printf("Scanner found listjobs!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return LISTJOBS;}

{bye} 		{printf("Scanner found bye!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return BYE;}

{run}		{printf("Scanner found run!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return RUN;}

{assignto}	{printf("Scanner found assignto!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return ASSIGNTO;}

{bg}		{printf("Scanner found <bg>!\n");
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return BG;}

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

