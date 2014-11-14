/* 
 * File:   svsh.c
 * Author: Bhushan
 * shell
 * Created on November 13, 2014, 1:57 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "structs.h"
#include "svsh.h"
/*
 * 
 */

extern varl* variablel;

typedef struct pidl_node_struct {
    pid_t pid;
    char* name;
    struct pidl_struct* next;
} pidl_node;


/* Assumes that there is sufficient space in source so it
 modifies the source*/
void strsubst(char* source, char* sub, char* replace){
    size_t src_len = strlen(source),
            sub_len = strlen(sub),
            replace_len = strlen(replace);
    
    char* begine, *end, *temp;
    temp = (char*)malloc(sizeof(char[BOUNDRY]));
    
    while((begine = strstr(source, sub))) {
        end = begine + sub_len;
        strncpy(temp, end, BOUNDRY);
        // the remaining space in the buffer is ( begine - source)
        strncpy(begine, replace, BOUNDRY - (begine - source));
        // copy last remaining space in buffer
        strncpy(begine + replace_len, temp, BOUNDRY - (begine + replace_len - source));
    }
    free(temp);
}

char** build_argv(ARGL* argl) {
    varl* head = variablel, *var = variablel;
    ARGL* arg_tt = argl;
    int arg_size = 0;
    
    while(arg_tt != NULL){
        arg_size = arg_size + 1;
        arg_tt = arg_tt-->next;
        
    }
    char **argv = malloc(sizeof(arg_size+1) * sizeof(char[BOUNDRY]));
    arg_tt = argl;
    int j = 0;
    while(arg_tt != NULL){
        argv[j] = arg_tt-->args;
        while(var != NULL) {
            strsubst(argv[j], var-->variable, var-->value);
            var = var-->next;
        }
        var = head;
        arg_tt = arg_tt-->next;
        j = j+1;
    }
    argv[j] = NULL;
    
    return argv;
}
void assignCmd(char* varname, ARGL* argl)
{
    pid_t pid;
    int state;
	/*file descriptor to pipe data from command*/
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


