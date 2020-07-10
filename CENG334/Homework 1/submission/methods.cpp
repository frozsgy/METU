#include "methods.hpp"

extern bool debug;

void readBidders(int n, std::vector<Bidder*>& Bidders)
{
    for (int i = 0; i < n; i++) {
        std::string name;
        int argcc = 0;
        std::cin >> name >> argcc;
        std::vector<std::string> argv(argcc);

        for (int j = 0; j < argcc; j++) {
            std::string arg;
            std::cin >> arg;
            argv[j] = arg;
        }
        
        Bidder* t = new Bidder(name, argcc, argv);
        Bidders[i] = t;
    }

}

void generateForks(int n, std::vector<Bidder*>& Bidders, int* pids, bool parent, char** forkargv, int** pipes, std::vector<char**>& heap)
{
    for (int i = 0; i < n; i++) {

        Bidder* bidder = Bidders[i];
        int forkargc = bidder->getArgCount();
        std::vector<std::string> forkargs = bidder->getArgs();
        pids[i] = fork();
        bidder->setPID(pids[i]);

        if (pids[i] == 0) {
            // child
            
            parent = false;

            if (debug) {
                log("fork succesful for id: " + std::to_string(i) + " pid: " + std::to_string(getpid()));
            }
            
            
            forkargv = new char*[forkargc + 2];
            heap.push_back(forkargv);
            
            forkargv[0] = new char[bidder->getName().length() + 1];
            strcpy(forkargv[0], bidder->getName().c_str());
            
            for (int j = 1; j < forkargc + 1; j++) {
                forkargv[j] = new char[forkargs[j-1].length() + 1];
                strcpy(forkargv[j], forkargs[j-1].c_str());
            }

            forkargv[forkargc + 1] = NULL;

            dup2(pipes[i][1], 1);
            dup2(pipes[i][1], 0);
            close(pipes[i][1]);

            if (debug) {
                log("pipe succesful for id: " + std::to_string(i));
            }
            
            if (execv(forkargv[0], forkargv)) {
                printf("warning: execve returned an error.\n"); 
                exit(-1);
            }

            printf("Child process should never get here\n");
            exit(42);

        }
    }
}


void parseMessages(int& starting_bid, int& current_bid, int& min_incr, int& currentBidders, int& winner, int n, int** pipes, std::vector<Bidder*>& Bidders, cm* clientMessage, sm* serverMessage, ii* input_data, oi* output_data, int& delayValue)
{
    bool finished = false;
    while ((n > 1 && currentBidders >= 1) || (n == 1 && finished == false))

        for (int i = 0; i < n; i++) {

            if (Bidders[i]->getStatus() == false) {
                continue;
            }

            if (delayValue == 0) {
                delayValue = 50;
            }

            struct timeval delay;
            delay.tv_sec = delayValue / 1000;
            delay.tv_usec = (delayValue % 1000) * 1000;
            
            fd_set readfds;
            FD_ZERO(&readfds);
            FD_SET(pipes[i][0], &readfds);

            int ret = select(pipes[i][0] + 1, &readfds, NULL, NULL, &delay);
            if (ret <= 0) {
                continue;
            }

            read(pipes[i][0], clientMessage, sizeof(*clientMessage));

            input_data->type = clientMessage->message_id;
            input_data->pid = Bidders[i]->getPID();
            input_data->info = clientMessage->params;
            print_input(input_data, i);
           
            if (clientMessage->message_id == CLIENT_CONNECT) {
                if (i == 0) {
                    delayValue = clientMessage->params.delay;
                } else if (clientMessage->params.delay < delayValue) {
                    delayValue = clientMessage->params.delay;
                }

                Bidders[i]->setDelay(clientMessage->params.delay);

                if (debug) {
                    log("got delay data for id: " + std::to_string(i) + " message id: " + std::to_string(clientMessage->message_id) + " delay: " + std::to_string(clientMessage->params.delay));
                }
            
                serverMessage->message_id = SERVER_CONNECTION_ESTABLISHED;
                serverMessage->params.start_info.client_id = i;
                serverMessage->params.start_info.starting_bid = starting_bid;
                serverMessage->params.start_info.current_bid = current_bid;
                serverMessage->params.start_info.minimum_increment = min_incr;

                output_data->type = SERVER_CONNECTION_ESTABLISHED;
                output_data->pid = Bidders[i]->getPID();
                output_data->info.start_info = serverMessage->params.start_info;
                print_output(output_data, i);

                write(pipes[i][0], serverMessage, sizeof(*serverMessage)); 

            } else if (clientMessage->message_id == CLIENT_BID) {
                
                if (debug) {
                    log("got bid data for id: " + std::to_string(i) + " message id: " + std::to_string(clientMessage->message_id) + " bid: " + std::to_string(clientMessage->params.bid));
                }

                serverMessage->message_id = SERVER_BID_RESULT;

                int bid = clientMessage->params.bid;

                if (bid < starting_bid) {
                    serverMessage->params.result_info.result = BID_LOWER_THAN_STARTING_BID;
                    if (debug) {
                        log("denied -- lower than starting");
                    }                    
                } else if (bid < current_bid) {
                    serverMessage->params.result_info.result = BID_LOWER_THAN_CURRENT;
                    if (debug) {
                        log("denied -- lower than current");
                    }  
                } else if (bid - current_bid < min_incr) {
                    serverMessage->params.result_info.result = BID_INCREMENT_LOWER_THAN_MINIMUM;
                    if (debug) {
                        log("denied -- lower than minimum");
                    }  
                } else {
                    serverMessage->params.result_info.result = BID_ACCEPTED;    
                    serverMessage->params.result_info.current_bid = clientMessage->params.bid;
                    winner = i;
                    current_bid = clientMessage->params.bid;
                    if (debug) {
                        log("accepted -- current maximum: " + std::to_string(clientMessage->params.bid));
                    }  
                }

                output_data->type = SERVER_BID_RESULT;
                output_data->pid = Bidders[i]->getPID();
                output_data->info.result_info = serverMessage->params.result_info;
                print_output(output_data, i);

                write(pipes[i][0], serverMessage, sizeof(*serverMessage)); 

            } else if (clientMessage->message_id == CLIENT_FINISHED) {

                Bidders[i]->setStatus(false);
                currentBidders--;

                if (debug) {
                    log("----------\nbidder " + std::to_string(i) + " quit with message id: " + std::to_string(clientMessage->message_id) + " status: " + std::to_string(clientMessage->params.status) + "\n----------");
                }

                int temp_delay = 2147483647;
                for (int j = 0; j < n; j++) {
                    if (Bidders[j]->getStatus() && Bidders[j]->getDelay() < temp_delay) {
                        temp_delay = Bidders[j]->getDelay();
                    }
                }

                delayValue = temp_delay;



                if (currentBidders < 1) {

                    print_server_finished(winner, current_bid);

                    for (int j = 0; j < n; j++) {
                            

                        serverMessage->message_id = SERVER_AUCTION_FINISHED;
                        serverMessage->params.winner_info.winner_id = winner;
                        serverMessage->params.winner_info.winning_bid = current_bid;

                        output_data->type = SERVER_AUCTION_FINISHED;
                        output_data->pid = Bidders[j]->getPID();
                        output_data->info = serverMessage->params;
                        print_output(output_data, j);

                        write(pipes[j][0], serverMessage, sizeof(*serverMessage)); 
                    }
                    
                    finished = true;

                    break;
                } 
            }
        }
}



void resultAndReap(int n, std::vector<Bidder*>& Bidders, int** pipes)
{
    int child_status;

    for (int i = 0; i < n; i++) {

        pid_t wpid = wait(&child_status);

        if (WIFEXITED(child_status)) {

            for (int j = 0; j < n; j++) {   

                if (Bidders[j]->getPID() == wpid) {

                    Bidders[j]->setExitStatus(WEXITSTATUS(child_status));
                    waitpid(wpid, &child_status, WNOHANG);
                    print_client_finished(j, Bidders[j]->getExitStatus(), child_status == Bidders[j]->getExitStatus()); 
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        close(pipes[i][1]);
        close(pipes[i][0]);
    }

}