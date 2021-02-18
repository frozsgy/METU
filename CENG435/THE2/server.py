import socket
import sys
from time import time

import util
from packet import Packet


def tcp(ip: str, port: int):
    """
    :param ip: ip address to receive data from (not used)
    :param port: port to listen to
    :return:
    """
    parcels = []                # list of data parcels
    file_name = ""              # file name
    file = b''                  # received data
    timestamp = [0, 0]          # start and finish timestamps
    packet_count = 0            # total nr of packets
    header_received = False     # flag to check if header was received

    # opening the socket using try-with-resources method
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        # bind to the receiving port to receive responses using that
        s.bind(('', port))
        # ready to receive, start listen
        s.listen()
        # start accepting packets
        connection, _ = s.accept()
        # try-with-resources for connection
        with connection:
            # loop until data fully received
            while True:
                # read 1024 bytes from the socket at each iteration
                data = connection.recv(1024)
                # if no data received, finish reading
                if not data:
                    # store finishing timestamp
                    timestamp[1] = time()
                    break
                # if headers not received, use the first data as header
                if not header_received:
                    # split received data to use as header
                    # use the remaining data as the actual data, since tcp is a stream
                    try:
                        deciphered = util.decipher(data)
                        if deciphered:
                            file_name, timestamp[0], packet_count, data = deciphered
                            # set flag
                            header_received = True
                    except Exception:
                        pass
                # append the received data to the parcel list
                parcels.append(data)
    # calculate total time spent at transfer
    tcp_total = (timestamp[1] - timestamp[0]) * 1000
    if packet_count != 0:
        tcp_average = tcp_total / packet_count
    else:
        tcp_average = 0
    print(f"TCP Packets Average Transmission Time: {tcp_average} ms")
    print(f"TCP Communication Total Transmission Time: {tcp_total} ms")
    # merge parcels
    for parcel in parcels:
        file += parcel
    # write to file
    with open(file_name, "wb") as file_pointer:
        file_pointer.write(file)


def udp(ip: str, port: int):
    """
    :param ip: ip address to receive data from (not used)
    :param port: port to listen to
    :return:
    """
    parcels = []                # list of data parcels
    file_name = ""              # file name
    file = b''                  # received data
    timestamp = [[0, 0]]        # start and finish timestamps
    packet_count = 0            # total nr of packets
    header_received = False     # flag to check if header was received
    packets_received = [False]  # list to check the first packet that did not arrive

    # try-with-resources for connection
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        # bind to the port
        s.bind(('', port))
        # loop until all data is received
        while True:
            # read 2048 bytes of data every loop
            data, client_address = s.recvfrom(2048)
            # if data is valid, handle it, else wait until data arrives
            if data:
                # if header was not received, treat the first packet as header
                if not header_received:
                    # try to decipher the data as header
                    header_try = util.decipher(data)
                    # if header can be parsed, then it is a valid header
                    # else wait until header
                    if header_try is not False:
                        # try to split header, since it might be corrupted
                        try:
                            file_name, timestamp[0][0], packet_count, data = header_try
                            # create the same header using the parsed data
                            new_header = util.generate(file_name, timestamp[0][0], packet_count)
                            # send it back as ACK
                            s.sendto(new_header.encode(), client_address)
                            # mark header received flag as True
                            header_received = True
                            # resize parcels list according to the packet count
                            parcels = [b""] * packet_count
                            # add first package receive time
                            timestamp[0][1] = time()
                            # resize timestamp list according to the packet count
                            timestamp_append = [[0, 0]] * packet_count
                            timestamp += timestamp_append
                            # resize packets received list according to the packet count
                            packets_received = [False] * packet_count
                        except Exception:
                            pass
                else:
                    # header was received already, treat the data as parcel
                    r = Packet.read_data_for_udp(data)
                    # if the data is a valid parcel, use and ack it
                    if r is not False:
                        parcel_nr, timestamp_p, parcel, hashed = r
                        # if the parcel nr is not registered, treat it as new
                        if not packets_received[parcel_nr]:
                            # save parcel, timestamp, and mark parcel as received
                            parcels[parcel_nr] = parcel
                            timestamp[parcel_nr + 1] = timestamp_p, time()
                            packets_received[parcel_nr] = True
                        # send ACK
                        s.sendto(hashed.encode(), client_address)
            # if all packets were received, break from the loop
            if packets_received.count(False) == 0:
                break

    # merge parcels
    for parcel in parcels:
        file += parcel
    # write to file
    with open(file_name, "wb") as file_pointer:
        file_pointer.write(file)
    # calculate time differences
    time_differences = [t[1] - t[0] for t in timestamp]
    udp_average = (sum(time_differences) / len(time_differences)) * 1000
    udp_total = (timestamp[-1][1] - timestamp[0][0]) * 1000
    print(f"UDP Packets Average Transmission Time: {udp_average} ms")
    print(f"UDP Communication Total Transmission Time: {udp_total} ms")


if __name__ == "__main__":
    args = sys.argv
    if len(args) != 3:
        print("Usage: python server.py [udp-port] [tcp-port]")
        exit()
    else:
        # read command line arguments
        udp_port = args[1]
        tcp_port = args[2]
        # if non-integer values were given as port values, exit peacefully
        try:
            udp_port = int(udp_port)
            tcp_port = int(tcp_port)
        except Exception:
            print("Port values must be integers", file=sys.stderr)
            exit()
        # get ip address of localhost
        ip_address = socket.gethostbyname(socket.gethostname())
        tcp(ip_address, tcp_port)
        udp(ip_address, udp_port)
