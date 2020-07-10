#ifndef CENG334HOMEWORK1_MESSAGE_H
#define CENG334HOMEWORK1_MESSAGE_H

#define CLIENT_CONNECT 1
#define CLIENT_BID 2
#define CLIENT_FINISHED 3

#define SERVER_CONNECTION_ESTABLISHED 1
#define SERVER_BID_RESULT 2
#define SERVER_AUCTION_FINISHED 3

#define BID_ACCEPTED 0
#define BID_LOWER_THAN_STARTING_BID 1
#define BID_LOWER_THAN_CURRENT 2
#define BID_INCREMENT_LOWER_THAN_MINIMUM 3

typedef union client_message_parameters {
    int status;
    int bid;
    int delay;
} cmp;

typedef struct client_message {
    int message_id; //non-zero and unique message id
    cmp params;
} cm;

typedef struct connection_established_info {
    int client_id;
    int starting_bid;
    int current_bid;
    int minimum_increment;
} cei;

typedef struct bid_info {
    int result;
    int current_bid;
} bi;

typedef struct winner_info {
    int winner_id;
    int winning_bid;
} wi;

typedef union server_message_parameters {
    cei start_info;
    bi result_info;
    wi winner_info;
} smp;

typedef struct server_message {
    int message_id; //non-zero and unique message id
    smp params;
} sm;

#endif //CENG334HOMEWORK1_MESSAGE_H
