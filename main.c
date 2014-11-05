#include "functions.h"

char *prompt = "svsh > ";


main(){
//	yylex();  	//the scanner
	printf("%s", prompt);
	yyparse();	//the parser
	return 0;
}
