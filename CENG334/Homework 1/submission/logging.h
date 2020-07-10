#ifndef CENG334HOMEWORK1_LOGGING_H
#define CENG334HOMEWORK1_LOGGING_H


#include "message.h"
#ifndef __cplusplus
#include <stdio.h>
#else
#include <cstdio>
#endif

typedef struct output_info {
    int type;
    int pid;
    smp info;
} oi;

typedef struct input_info {
    int type;
    int pid;
    cmp info;
} ii;

void print_output(oi* data, int client_id);
void print_input(ii* data, int client_id);
void print_server_finished(int winner, int winning_bid);
void print_client_finished(int client_id, int status, int status_match);
#endif //CENG334HOMEWORK1_LOGGING_H
