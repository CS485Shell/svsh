#ifndef SVSH_H_INCLUDED
#define SVSH_H_INCLUDED

#define SaveVar 315 //System Call #315 is the int SaveVariable function
#define GetVar 316 //System Call #316 is int GetVariable function
#define NextVar 317 //System Call #317 is the int NextVariable function
#define MAXSTRINGLENGTH  256
#define MAXARGNUMS 256
#define MAX_JOBS 20
//Only include c std .h files in this header to avoid gcc and C++ comflints
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "mytable.h"

//extern int Debug;
extern int ChangeDir(char* directory);
extern int Showtokens;
extern char *prompt;
//extern int input_argc;
//extern char** input_argv;


//Sharing variables functions
int SaveVariable(char *varname, char *vardef);
int GetVariable(char *varname, char *vardef, int deflen);
int NextVariable(char *prevname, char *varname, int namelen, char *vardef, int deflen);

#endif
