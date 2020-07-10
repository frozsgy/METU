#include "bidder.hpp"

Bidder::Bidder()
{

}

Bidder::Bidder(std::string name, int argc, std::vector<std::string> argv)
{
    this->name = name;
    this->argv = argv;
    this->argc = argc;
}

Bidder::Bidder(const Bidder& rhs)
{
    this->name = rhs.getName();
    this->argv = rhs.getArgs();
    this->argc = rhs.getArgCount();
}

Bidder::~Bidder() 
{

}

std::string Bidder::getName() const 
{
    return this->name;
}

std::vector<std::string> Bidder::getArgs() const 
{
    return this->argv;
}

int Bidder::getArgCount() const 
{
    return this->argc;
}

int Bidder::getDelay() const 
{
    return this->delay;
}

struct timeval Bidder::getDelayStruct() const
{
    struct timeval delayStruct;
    delayStruct.tv_sec = this->delay / 1000;
    delayStruct.tv_usec = (this->delay % 1000) * 1000;
    return delayStruct;
}

void Bidder::setDelay(int delay)
{
    this->delay = delay;
}

pid_t Bidder::getPID() const
{
    return this->pid;
}

void Bidder::setPID(pid_t pid)
{
    this->pid = pid;
}

int Bidder::getExitStatus() const
{
    return this->exit_status;
}

void Bidder::setExitStatus(int status)
{
    this->exit_status = status;
}

bool Bidder::getStatus() const
{
    return this->isActive;
}

void Bidder::setStatus(bool status)
{
    this->isActive = status;
}
