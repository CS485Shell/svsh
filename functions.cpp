//functions.cpp
//CS485 Project 3 - svsh
//11-3-14 
//Contains the core functions and built-in commands for the shared variable
//shell (svsh). Also includes global variables used throughout
//the shell and initializes them to a default value.

#include "functions.h"
#include <string.h>
//#include <iostream>
#include <unistd.h>
#include <stdio.h>
#include <cstdio>


//using namespace std;



//int ChangeDir(char* directory)
//This function reads in a command line from stdin to prepare it to be used
//by other functions. It can be given different return values to represent
//different shell exit codes which we can handle in main().)
        




else if (command == "listjobs")
	        {
	                // List all jobs running in the background
	                printf("listjobs call has been made. \n");
			int j, n;
			n = sizeof(jobs)/sizeof(jobs[0]);
			for(j=0;j<n;j++)
			{
				printf("%s %d\n", jobs[i], i);
			}
}


void run(int argc, char** argv)
{
    
}

