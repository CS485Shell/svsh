#include "functions.h"

int Debug = 0;
int Showtokens = 1;
char *prompt;

int input_argc = 1;
char** input_argv;

//This symbol table is a linked list of struct symrec's (symbol records)
symrec *sym_table = NULL;

//Push the current list down, adding a new record to the front of the table
symrec* pushsym (sym_type, sym_value, sym_usage)
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
	strncpy(ptr->value, sym_value, strlen(sym_value));//MAXSTRINGLENGTH);
	//Assign the usage (run etc.)
	ptr->usage = (char *)malloc(MAXSTRINGLENGTH);
	strncpy(ptr->usage, sym_usage, strlen(sym_usage));//MAXSTRINGLENGTH);
	//Put the pointer at the front end of the list
	ptr->next = sym_table;
	/*if(sym_table == NULL){
		sym_table = ptr;
	} else{	
		symrec* ptr2 = sym_table;
		while(ptr2->next != NULL){
			ptr2 = ptr2->next;
		}
		ptr2->next = ptr;
	}*/
	return ptr;
}

//Put a new record at the end of the list of symbols
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
	strncpy(ptr->value, sym_value, strlen(sym_value));//MAXSTRINGLENGTH);
	//Assign the usage (run etc.)
	ptr->usage = (char *)malloc(MAXSTRINGLENGTH);
	strncpy(ptr->usage, sym_usage, strlen(sym_usage));//MAXSTRINGLENGTH);
	//Put the pointer at the end of the list
	ptr->next = NULL;
	if(sym_table == NULL){
		sym_table = ptr;
	} else{	
		symrec* ptr2 = sym_table;
		while(ptr2->next != NULL){
			ptr2 = ptr2->next;
		}
		ptr2->next = ptr;
	}
	return sym_table;
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

void init_table(){
	sym_table = (symrec *)malloc(sizeof(symrec));
	sym_table->type = 0;
	sym_table->value = (char *)malloc(MAXSTRINGLENGTH);
	sym_table->usage = (char *)malloc(MAXSTRINGLENGTH);
	sym_table->next = NULL;
}

void free_table(){
	if(sym_table == NULL)
		return;
	while(sym_table != NULL){
		symrec *ptr = sym_table;
		if(ptr->next == NULL){
			//free(ptr->value);
			//free(ptr->usage);
			free(ptr);
			sym_table = NULL;
			return;
		}
		while(ptr->next->next != NULL){
			ptr = ptr->next;
		}
		
		//free(ptr->next->value);
		//free(ptr->next->usage);
		free(ptr->next);
		ptr->next = NULL;
	}
}

main(){
	//Sets the initial prompt
	prompt = malloc(MAXSTRINGLENGTH);
	strncpy(prompt, "svsh >", MAXSTRINGLENGTH);
	input_argv = malloc(MAXARGNUMS * sizeof(char*));

	//Initialize the table by allocating space for the first entry
	//init_table();

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
		free_table();
	}
	return 0;
}
