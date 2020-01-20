/*
 * driver.h - Various definitions for the Performance Lab.
 * 
 * DO NOT MODIFY ANYTHING IN THIS FILE
 */
#ifndef _DEFS_H_
#define _DEFS_H_

#include <stdlib.h>

#define RIDX(i,j,n) ((i)*(n)+(j))

typedef struct {
  char *team;
  char *name1, *email1;
  char *name2, *email2;
} team_t;

extern team_t team;



typedef void (*lab_test_func3) (int, int*,  int*);

typedef void (*lab_test_func5) (int, int*, int*);


void sobel(int, int *, int *);

void mirror(int, int *, int *);



void register_sobel_functions(void);

void register_mirror_functions(void);




void add_mirror_function(lab_test_func3, char*);

void add_sobel_function(lab_test_func5, char*);

#endif /* _DEFS_H_ */

