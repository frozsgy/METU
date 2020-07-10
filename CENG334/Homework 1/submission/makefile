CC=g++
CFLAGS=-c -std=c++14 

all: logging.o server.o bidder.o utils.o methods.o
	$(CC) server.o logging.o bidder.o utils.o methods.o -o server

logging.o: logging.h message.h
	$(CC) $(CFLAGS) logging.c -o logging.o

server.o: server.cpp
	$(CC) $(CFLAGS) server.cpp -o server.o

bidder.o : bidder.cpp
	$(CC) $(CFLAGS) bidder.cpp -o bidder.o

utils.o : utils.cpp
	$(CC) $(CFLAGS) utils.cpp -o utils.o

methods.o : methods.cpp
	$(CC) $(CFLAGS) methods.cpp -o methods.o

clean:
	rm -f *.o
	rm server