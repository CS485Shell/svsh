/* Project 3
 * This is the .lex file which describes a scanner that flex will construct	
 * Uncomment the printfs to see what gets scanned
 */

%{
#include <stdlib.h>
#include "functions.h"
#include "project3.tab.h"

#define DEBUGSCANNER 0
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

<<EOF>>		{yylval.str_val = "bye";
		 return BYE;}

{newline}	{if(DEBUGSCANNER)printf("Scanner found a newline character!\n");
		return 0;}		
{defprompt}	{if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		if(DEBUGSCANNER)printf("Scanner found defprompt!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return DEFPROMPT;}

{cd}		{if(DEBUGSCANNER)printf("Scanner found cd!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return CD;}

{listjobs} 	{if(DEBUGSCANNER)printf("Scanner found listjobs!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return LISTJOBS;}

{bye} 		{if(DEBUGSCANNER)printf("Scanner found bye!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return BYE;}

{run}		{if(DEBUGSCANNER)printf("Scanner found run!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return RUN;}

{assignto}	{if(DEBUGSCANNER)printf("Scanner found assignto!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return ASSIGNTO;}

{bg}		{if(DEBUGSCANNER)printf("Scanner found <bg>!\n");
		//if(Showtokens)printf("Token type = keyword\tToken = %s\t\t", yytext);
		yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		return BG;}

{variable}	{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		if(DEBUGSCANNER)printf("Scanner found variable: %s!\n", yytext); 
		//if(Showtokens)printf("Token type = variable\tToken = %s\t\t", yytext);
		return VARIABLE;}

{string}	{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		if(DEBUGSCANNER)printf("Scanner found string: %s!\n", yytext); 
		//if(Showtokens)printf("Token type = string\tToken = %s\t\t", yytext);
		return STRING;}

{metacharacter}	{yylval.int_token = *(yytext); 
		if(DEBUGSCANNER)printf("Scanner found the metacharacter: %s!\n", yytext); 
		//if(Showtokens)printf("Token type = metachar\tToken = %s\t\t", yytext);
		return METACHARACTER;}

{word}		{yylval.str_val = (char*) malloc(yyleng); 
		strncpy(yylval.str_val, yytext, yyleng); 
		if(DEBUGSCANNER)printf("Scanner found the word: %s!\n", yytext); 
		//if(Showtokens)printf("Token type = word\tToken = %s\t\t", yytext);
return WORD;}
%%

void yyerror(char* str) {printf("Parse Error: \n%s\n",str);}
int yywrap(void){}

