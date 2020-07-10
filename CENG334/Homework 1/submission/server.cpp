#include "logging.h"
#include "bidder.hpp"
#include "utils.hpp"
#include "methods.hpp"

#include <sys/socket.h>
#include <sys/wait.h> 
#include <sys/types.h>
#include <unistd.h>

#include <iostream>
#include <vector>
#include <string>

#define PIPE(fd) socketpair(AF_UNIX, SOCK_STREAM, PF_UNIX, fd)

bool debug = false;

int main(int argc, char **argv) 
{

    bool parent = true;
    int starting_bid = 0;
    int n = 0;
    int min_incr = 0;
    int current_bid = 0;
    int winner = -1;
    int delay = 0;
    
    std::cin >> starting_bid >> min_incr >> n;
    
    int currentBidders = n;
    int* pids = new int[n];
    char** forkargv = nullptr;
    std::vector<char**> heap;
    std::vector<Bidder*> Bidders(n);
    
    int** pipes = new int*[n];

    for (int i = 0; i < n; i++) {
        pipes[i] = new int[2];
    }

    cm* clientMessage = new cm;
    sm* serverMessage = new sm;
    ii* input_data = new ii;
    oi* output_data = new oi;
    
    readBidders(n, Bidders);

    for (int i = 0; i < n; i++) {
        if (PIPE(pipes[i]) < 0) {
            perror("PIPE error");
            if (debug) {
                log("PIPE error");
            }
        }  
    }

    generateForks(n, Bidders, pids, parent, forkargv, pipes, heap);

    if (parent && debug) {
        log("parent pid: " + std::to_string(getpid()));
    }

    parseMessages(starting_bid, current_bid, min_incr, currentBidders, winner, n, pipes, Bidders, clientMessage, serverMessage, input_data, output_data, delay);

    resultAndReap(n, Bidders, pipes);

    cleanup(n, Bidders, heap, pids, pipes, clientMessage, serverMessage, input_data, output_data);

    return 0;
}