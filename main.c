#include "functions.h"

char *prompt = "svsh > ";


main(){
//	yylex();  	//the scanner
	while(1){
		printf("%s", prompt);
		yyparse();	//the parser
	}
	return 0;
}
