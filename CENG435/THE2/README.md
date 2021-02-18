# CENG435 HW2 - Socket Programming Assignment

## How to run?

This project consists of 4 files, and only 2 of them are executables, namely `server.py` and `client.py`. The other files are required by these files, and should be in the same directory with them.

### Running client.py

Place `client.py`, `packet.py`, `util.py` and files to be transferred (namely, `transfer_file_TCP.txt` and `transfer_file_UDP.txt`) in the same directory. Then run the following command:

`python3 client.py [server-ip] [server-udp-listen] [server-tcp-listen] [client-udp-sender] [client-tcp-sender]`

### Running server.py

Place `server.py`, `packet.py`, and `util.py` in the same directory. Then run the following command:

`python3 server.py [udp-port] [tcp-port]`

## Main Steps of Development

### Development Steps

1. Review of TCP and UDP
2. Experimenting with the TCP/UDP codes in the lecture slides
3. Creating the general overview of the project
4. Starting development with parsing command line arguments
5. Util header methods to be used with TCP and UDP implementation
6. File operations methods implementation
7. TCP protocol implementation
8. UDP protocol implementation
9. RDT implementation

### Deciding on the Programming Language

Before starting the development, I thought of using C or C++ to develop this project, because knowing the exact sizes of the structs seemed beneficial. However after doing some research, I saw that C or C++ sockets will bring more problems than they solve, and since Python is the preferred language for this assignment, I decided to continue with Python and develop some extra methods to solve some problems that I thought would occur.

### Problems Faced

- Timeout issues and broken pipes while using inek's 
- Python not releasing the TCP ports after a forced quit for a minute or so

### Total Days 

It took around 3 days to complete this assignment (excluding prior study of the topic)

### Things Learned from this Assignment

TCP is way easier to implement however when I bind a port, it takes some time for the OS to relieve that port back. UDP does not have this limitation, however it is not reliable itself, so a reliable layer is needed. Both methods have their pros and cons, and a decision should be made case-by-case basis. 

### Extra Features

I wanted this project to work on arbitrary files, so I transfer the file name over the socket as well. This will allow future extension of providing the file to be transferred as a command line argument.


## RDT Protocol

In this assignment, I used something that is quite similar to rdt3.0. 

The client and the server keep a list of boolean values reflecting the sent & ACK'd status of packages. The client also keeps the value of the last successful ACK'd package id. 

1. Client sends package with data, parcel id and a checksum (by using the smallest id with False ACK)
2. Server calculates the checksum using the data and compares with the received checksum (If it's not the first successful arrival of this package, this step gets skipped since the server already has the correct data for this package)
3. If match, server sends the checksum back to the client. If not, server waits since the client will timeout and re-send the package soon.
4. If the checksum is received back from the server, and it matches with the checksum of the first package with the False ACK value, this package gets marked as ACK'd, and the smallest package number gets incremented. 
5. The loop continues until all packages are delivered successfully.

One of the weaknesses of this protocol is that it's not pipelined and does not move forward until a package is delivered successfully, therefore causing performance issues. 