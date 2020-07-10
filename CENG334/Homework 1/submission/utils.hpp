#ifndef CENG334HOMEWORK1_UTILS_HPP
#define CENG334HOMEWORK1_UTILS_HPP

#include "bidder.hpp"
#include "logging.h"

#include <iostream>
#include <fstream>
#include <vector>
#include <string>

void log(std::string val);

void cleanup(int n, std::vector<Bidder*>& Bidders, std::vector<char**>& heap, int* pids, int** pipes, cm* clientMessage, sm* serverMessage, ii* input_data, oi* output_data);

#endif //CENG334HOMEWORK1_UTILS_HPP