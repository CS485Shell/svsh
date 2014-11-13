/* 
 * File:   svsh.c
 * Author: Bhushan
 *
 * Created on November 13, 2014, 1:57 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "structs.h"
#include "svsh.h"
/*
 * 
 */

extern VARL* variablel;

typedef struct pidl_node_struct {
    pid_t pid;
    char* name;
    struct pidl_struct* next;
} pidl_node;
void assignCmd(char* variable, ARGL* argl)
{
    pid_t pid;
    int state;
	
int fd[2];

char** argv = build_argv(argl);
char* result = (char*)malloc(sizeof(char[BOUNDRY]));


pipe(fd);
if((pid = fork()) == 0) 
{
	dup2(fd[1], STDOUT_FILENO);
        execvp(argv[0], argv)
	execvp(argv[0], argv);
	exit(1);
}
if(waitpid(pid, &state, 0) < 0)
{
	perror("WAITPID");
	kill(pid, SIGKILL);
	
}
// Read the output into a variable 
read(fd[0], result, BOUNDRY);
result[BOUNDRY-1] = '\0';
//addToVariableList(variable, result);
free(argv);
}

