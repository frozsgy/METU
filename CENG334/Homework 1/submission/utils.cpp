#include "utils.hpp"

void log(std::string val)
{
    std::fstream fs;
    fs.open("log.txt", std::fstream::app);
    fs << val << std::endl;
    fs.close();
}

void cleanup(int n, std::vector<Bidder*>& Bidders, std::vector<char**>& heap, int* pids, int** pipes, cm* clientMessage, sm* serverMessage, ii* input_data, oi* output_data)
{
    for (Bidder* t: Bidders) {
        delete t;
    }
    for (char** t: heap) {
        delete[] t;
    }
    for (int i = 0; i < n; i++) {
        delete[] pipes[i];
    }
    delete[] pipes;
    delete[] pids;
    delete clientMessage;
    delete serverMessage;
    delete input_data;
    delete output_data;
}