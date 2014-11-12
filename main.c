#include "functions.h"

int Debug = 0;
int Showtokens = 1;
char *prompt;


main(){
	prompt = malloc(MAXSTRINGLENGTH);
	strncpy(prompt, "svsh >", MAXSTRINGLENGTH);
	while(1){
				
		printf("%s", prompt);
		yyparse();	//the parser
		printf("\n");
	}
	return 0;
}
