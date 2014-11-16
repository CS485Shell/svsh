#include "functions.h"

//int Debug = 0;
int Showtokens = 1;
char *prompt;

//This symbol table is a linked list of struct symrec's (symbol records)
symrec *sym_table = NULL;

//Push the current list down, adding a new record to the front of the table
//(so the new entry is the root of the list)
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
	symrec *ptr = sym_table;
	while(ptr != NULL){
		symrec *ptr2 = ptr;
		ptr = ptr->next;
		//free(ptr2->value);
		ptr2->value = NULL;
		//free(ptr2->usage);
		ptr2->usage = NULL;
		//free(ptr2);
		ptr2 = NULL;	
	}
	sym_table = NULL;
}

main(){
	//Sets the initial prompt
	prompt = malloc(MAXSTRINGLENGTH);
	strncpy(prompt, "svsh > ", MAXSTRINGLENGTH);
	int i;
	for (i = 0; i < 1024; i++){
		i_jobs[i] = NULL;
	}
	strncpy(jobs, "", MAXSTRINGLENGTH);

	while(1){
				
		printf("%s", prompt);
		yyparse();	//the parser
		//printf("\n");
		free_table();
	}
	return 0;
}
