#include "functions.h"

int Debug = 0;
int Showtokens = 1;
char *prompt;

int input_argc = 1;
char** input_argv;

//This symbol table is a linked list of struct symrec's (symbol records)
symrec *sym_table = (symrec*)0;

symrec* putsym (sym_type, sym_value, sym_usage)
	int sym_type;
	char *sym_value;
	char *sym_usage;
{
	//Create a pointer for the new entry
	symrec *ptr;
	ptr = (symrec *)malloc(sizeof(symrec));
	//Assign the type (token types are ints)
	ptr->type = sym_type;
	//Assign the value (all tokens are strings)
	ptr->value = (char *)malloc(MAXSTRINGLENGTH);
	strncpy(ptr->value, sym_value, MAXSTRINGLENGTH);
	//Assign the usage (run etc.)
	ptr->usage = (char *)malloc(MAXSTRINGLENGTH);
	strncpy(ptr->usage, sym_usage, MAXSTRINGLENGTH);
	//The next pointer is a pointer to another entry
	ptr->next = (struct symrec *)sym_table;
	sym_table = ptr;
	return ptr;
}

//Not sure if it's needed to get a symbol by its value
symrec* getsym (sym_name) 
	char *sym_name;
{
	symrec *ptr;
	for (ptr = sym_table; ptr != (symrec *)0; ptr = (symrec *)ptr->next)
	  if (strcmp (ptr->value,sym_name) == 0)
		return ptr;
	return 0;
}

main(){
	prompt = malloc(MAXSTRINGLENGTH);
	strncpy(prompt, "svsh >", MAXSTRINGLENGTH);
	input_argv = malloc(MAXARGNUMS * sizeof(char*));
	while(1){
				
		printf("%s", prompt);
		//Reset the number of arguments to 0
		input_argc = 1;
		/* Reset argument list?
		int i;
		for (i = 0; i < MAXARGNUMS; i++){
			input_argv[i] = "";
		}
		*/
		yyparse();	//the parser
		printf("\n");
	}
	return 0;
}
