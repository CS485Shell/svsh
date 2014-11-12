#ifndef MYTABLE_H_INCLUDED
#define MYTABLE_H_INCLUDED

#include "functions.h"

struct symrec
{
    int type;	/* type of symbol: metachar, etc. */
    char *value;
    char *usage;  /* how it is being used */
    struct symrec *next; /* next token */
};

typedef struct symrec symrec; 	/* typdef so the type is known elsewhere */
extern symrec *sym_table;	/* (main) pointer to the symbol table */

symrec *putsym();		/* puts a new symbol table entry */
symrec *getsym();		/* gets a symbol table entry */



#endif
