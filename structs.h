/* 
 * File:   structs.h
 * Author: Bhushan
 *
 * Created on November 13, 2014, 2:00 PM
 */

#ifndef STRUCTS_H
#define	STRUCTS_H


#include <stdlib.h>


#define BOUNDRY 256

typedef struct argl{
    struct argl *next;
    char args[BOUNDRY];
    //struct args[BOUNDRY];
 } ARGL;
 
 typedef struct variablel{
     struct variablel *next;
     struct variablel *prev;
     char variable[BOUNDRY];
     
 }varl;
