#ifndef CENG334HOMEWORK1_BIDDER_HPP
#define CENG334HOMEWORK1_BIDDER_HPP

#include <iostream>
#include <vector>
#include <string>
#include <sys/types.h>

class Bidder {
private:
    std::string name;
    std::vector<std::string> argv;
    int argc;
    int delay = 50;
    pid_t pid;
    int exit_status;
    bool isActive = true;

public:
    Bidder();
    Bidder(std::string name, int argc, std::vector<std::string> argv);
    Bidder(const Bidder& rhs);
    ~Bidder();
    std::string getName() const;
    std::vector<std::string> getArgs() const;
    int getArgCount() const;
    int getDelay() const;
    struct timeval getDelayStruct() const;
    void setDelay(int delay);
    pid_t getPID() const;
    void setPID(pid_t pid);
    int getExitStatus() const;
    void setExitStatus(int status);
    bool getStatus() const;
    void setStatus(bool status);

};

#endif //CENG334HOMEWORK1_BIDDER_HPP