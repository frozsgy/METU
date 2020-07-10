#ifndef CENG334HOMEWORK1_METHODS_HPP
#define CENG334HOMEWORK1_METHODS_HPP

#include "logging.h"
#include "bidder.hpp"
#include "utils.hpp"

#include <sys/socket.h>
#include <sys/wait.h> 
#include <sys/types.h>
#include <unistd.h>

#include <iostream>
#include <vector>
#include <string>
#include <cstring>

void readBidders(int n, std::vector<Bidder*>& Bidders);

void generateForks(int n, std::vector<Bidder*>& Bidders, int* pids, bool parent, char** forkargv, int** pipes, std::vector<char**>& heap);

void parseMessages(int& starting_bid, int& current_bid, int& min_incr, int& currentBidders, int& winner, int n, int** pipes, std::vector<Bidder*>& Bidders, cm* clientMessage, sm* serverMessage, ii* input_data, oi* output_data, int& delayValue);

void resultAndReap(int n, std::vector<Bidder*>& Bidders, int** pipes);

#endif //CENG334HOMEWORK1_METHODS_HPP