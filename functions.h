#ifndef SVSH_H_INCLUDED
#define SVSH_H_INCLUDED

#define MAXSTRINGLENGTH  120

//Only include c std .h files in this header to avoid gcc and C++ comflints
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char *prompt;
extern int Showtokens;
extern int Debug;

//Sharing variables functions
int SaveVariable(char *varname, char *vardef);
int GetVariable(char *varname, char *vardef, int deflen);
int NextVariable(char *prevname, char *varname, int namelen, char *vardef, int deflen);

#endif
