#include "logging.h"

void print_output(oi* data, int client_id) {
    printf("COMM: 1 CID: %d TYPE: %d PID: %d ", client_id, data->type, data->pid);
    if (data->type == SERVER_CONNECTION_ESTABLISHED)
        printf("SBID: %d CBID: %d MI: %d \n", data->info.start_info.starting_bid, data->info.start_info.current_bid, data->info.start_info.minimum_increment);
    else if (data->type == SERVER_BID_RESULT)
        printf("RESULT: %d CBID: %d \n", data->info.result_info.result, data->info.result_info.current_bid);
    else
        printf("WINNER: %d WBID: %d \n", data->info.winner_info.winner_id, data->info.winner_info.winning_bid);
}

void print_input(ii* data, int client_id) {
    printf("COMM: 0 CID: %d TYPE: %d PID: %d ", client_id, data->type, data->pid);
    if (data->type == CLIENT_CONNECT)
        printf("DELAY: %d \n", data->info.delay);
    else if (data->type == CLIENT_BID)
        printf("BID: %d \n", data->info.bid);
    else
        printf("STATUS: %d \n", data->info.status);
}

void print_server_finished(int winner, int winning_bid) {
    printf("COMM: 2 W: %d WB: %d\n", winner, winning_bid);
}

void print_client_finished(int client_id, int status, int status_match) {
    printf("COMM: 3 CID: %d STATUS: %d SM: %d\n", client_id, status, status_match);
}