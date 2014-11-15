//p3syscalls.c
//CS485-001 Project 3
//Michael Carlton, Shannon Simpson, Bhushan Chitre, Bryan Potere
//System calls for shared variable shell (svsh)
#include <linux/linkage.h>
#include <linux/kernel.h>
#include <asm/uaccess.h>

#define MAX_BUF_SIZE 500 //Max buffer size set arbitrarily to 512 characters
#define MAX_VAR_SIZE 20 //Max # variables is 20

static char def[MAX_VAR_SIZE][MAX_BUF_SIZE]; //buffer to store user's variable definitions
static char var[MAX_VAR_SIZE][MAX_BUF_SIZE]; //buffer to store user's variables
static bool initialized = false; //Test to see if the arrays have been initialized

//Initialization function
void init_array(char ary[][MAX_BUF_SIZE]) {
	int i, j;
	for (i = 0; i < MAX_VAR_SIZE; i++) {
		for (j = 0; j < MAX_BUF_SIZE-1; j++) {
			ary[i][j] = '0';
		}
		ary[i][MAX_BUF_SIZE-1] = '\0';
	}
}

//Stores a variable and definition in the kernel. Returns 0 on success and -1 on failure.
asmlinkage int SaveVariable(char *varname, char *vardef)
{
	int i = 0; //Counter
	bool exit = false; //when to exit loop
	char tmp[1][MAX_BUF_SIZE-1]; //tmp buffer to test if array is empty
	char buf[MAX_BUF_SIZE]; //buffer to hold copy data

	
	//Initialize variable arrays
	memset(tmp, '0', MAX_BUF_SIZE-1); //Initialize test buffer
	if (!initialized) {
		init_array(def);
		init_array(var);
		initialized = true;
	}

	//Get variable name and definition and store in parallel arrays
	i = 0;
	while ( (i < MAX_VAR_SIZE) && (exit == false) )
	{
		if (strcmp(var[i], tmp[0]) == 0)
		{
			//Copy variable name to array
			if (copy_from_user(buf, varname, sizeof(varname)))
			{
				return(-1); //Copy failed if copy_from_user = 1
			}
			strncpy(var[i], buf, sizeof(buf));
			//Copy definition to array
			if (copy_from_user(buf, vardef, sizeof(vardef)))
			{
				return(-1);
			}
			strncpy(def[i], buf, sizeof(buf));
			exit = true;
		}
		i++;
	}
	if (exit) {
		return(0); //Successfully saved variable
	}
	else {
		return(-1); //Error catching for anything else
	}
}

//Gets a stored variable and returns it to user. Returns 0 on success and -1 if not found
asmlinkage int GetVariable(char *varname, char *vardef, int deflen)
{
	int i = 0;
	while (i < MAX_VAR_SIZE)
	{
		if (strcmp(var[i], varname) == 0)
		{
			copy_to_user(vardef, def[i], deflen); //def[i] matches var[i]
			return(0); //Return 0 if variable found successfully
		}
	}
	return(-1); //Return -1 if variable not found or other error occurred
}

//Returns next variable and definition to user. Success = 0, Failure = -2, No more variables = -1
asmlinkage int NextVariable(char *prevname, char *varname, int namelen, char *vardef, int deflen)
{
	int i = 0;
	while (i < MAX_VAR_SIZE-1)
	{
		if ( (strcmp(var[i], prevname) == 0) || (strcmp(prevname, "") == 0) )
		{
			if (strcmp(var[i], prevname) == 0)
			{
				if (copy_to_user(varname, var[i+1], namelen) || copy_to_user(vardef, def[i+1], deflen))
				{
					return(-2); //Error on copy_to_user
				}
			}
			else //prevname == ""
			{
				if (copy_to_user(varname, var[i], namelen) || copy_to_user(vardef, def[i], deflen))
                                {
                                        return(-2); //Error on copy_to_user
                                }
			}	
			return(0); //copy_to_user was successful and variable/definition were sent to user
		}
		i++;
	}
	return(-1); //No more variables found
}
