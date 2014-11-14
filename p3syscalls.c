//p3syscalls.c
//CS485-001 Project 3
//Michael Carlton, Shannon Simpson, Bhushan Chitre, Bryan Potere
//System calls for shared variable shell (svsh)
#include <linux/linkage.h>
#include <linux/kernel.h>
#include <asm/uaccess.h>

#define MAX_BUF_SIZE 1000
#define MAX_VAR_SIZE 20 //Max # variables is 20

static char def[MAX_VAR_SIZE][MAX_BUF_SIZE]; //buffer to store user's variable definitions
static char var[MAX_VAR_SIZE][MAX_BUF_SIZE]; //buffer to store user's variables
static int i; //counter for initialization

//Initialization
for (i = 0; i < MAX_VAR_SIZE; i++)
{
	var[i] = "_novar";
	def[i] = "_nodef";
}

//Stores a variable and definition in the kernel. Returns 0 on success and -1 on failure.
asmlinkage int SaveVariable(char *varname, char *vardef)
{
	bool exit = false; //when to exit loop
	char tmp[MAX_BUF_SIZE]; //tmp buffer to store user data
	
	//Get variable name
	i = 0;
	while ( (i < MAX_VAR_SIZE) && (exit == false) )
	{
		if (var[i] == "_novar")
		{
			if (copy_from_user(tmp, varname, sizeof(varname)))
			{
				return(-1); //Copy failed if copy_from_user = 1
			}
			var[i] = tmp;
			exit = true;
		}
		i++;
	}
	
	//Get definition
	i = 0;
	exit = false;
	while ( (i < MAX_VAR_SIZE) && (exit == false) )
	{
		if (def[i] == "_nodef")
		{
			if (copy_from_user(tmp, vardef, sizeof(vardef)))
			{
				return(-1); //Copy failed if copy_from_user = 1
			}
			def[i] = tmp;
			exit = true;
		}
		i++;
	}
	//var and def are parallel and SHOULD have matching value pairs
	return(0); //Copy successful otherwise
}

//Gets a stored variable and returns it to user. Returns 0 on success and -1 if not found
asmlinkage int GetVariable(char *varname, char *vardef, int deflen)
{
	i = 0;
	while (i < MAX_VAR_SIZE)
	{
		if (var[i] == varname)
		{
			copy_to_user(vardef, def[i], deflen); //def[i] matches var[i]
			return(0); //Return 0 if variable found successfully
		}
	}
	return(-1); //Return -1 if variable not found
}

//Returns next variable and definition to user. Success = 0, Failure = -2, No more variables = -1
asmlinkage int NextVariable(char *prevname, char *varname, int namelen, char *vardef, int deflen)
{
	i = 0;
	while (i < MAX_VAR_SIZE-1)
	{
		if ( (var[i] == prevname) || (prevname == "") )
		{
			if (copy_to_user(varname, var[i+1], namelen) || copy_to_user(vardef, def[i+1], deflen))
			{
				return(-2); //Error on copy_to_user
			}
			return(0); //copy_to_user was successful and variable/definition were sent to user
		}
		i++;
	}
	return(-1); //No more variables found
}
