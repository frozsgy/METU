import socket
import sys
from time import time

import util
from packet import Packet


def tcp(ip: str, sender: int, receiver: int):
    """
    :param ip: ip address to send tcp packets
    :param sender: sender port
    :param receiver: receiver port
    :return: void
    """
    # i created a separate class to process files and split them accordingly.
    # for further information, you may refer to the packet.py file.
    file_name = "transfer_file_TCP.txt"
    p = Packet(file_name)
    packet_count = p.packet_count
    # opening the socket using try-with-resources method
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        # bind to the sender port to receive responses using that
        s.bind(('0.0.0.0', sender))
        # get data split as packets using the packet.py methods
        packets = list(p.split_data())
        # connect to the server using the ip and the port
        s.connect((ip, receiver))
        # a header was implemented to send file name, timestamp and packet count.
        header = util.generate(file_name, time(), packet_count)
        # send the header before sending the data packets.
        s.send(header.encode())
        # send data packets
        for i in range(packet_count):
            s.sendall(packets[i])


def udp(ip: str, sender: int, receiver: int):
    """
    :param ip: ip address to send tcp packets
    :param sender: sender port
    :param receiver: receiver port
    :return:
    """
    # i created a separate class to process files and split them accordingly.
    # for further information, you may refer to the packet.py file.
    file_name = "transfer_file_UDP.txt"
    p = Packet(file_name)
    packet_count = p.packet_count
    # get data split as packets using the packet.py methods
    packets = list(p.split_data_for_udp())
    # generate the header to send as the first package
    header = util.generate(file_name, time(), packet_count)
    header_sent = False                         # flag to check if header was sent
    packets_sent = [False] * packet_count       # flag to check if packets sent
    last_sent = 0                               # id of the last successfully sent package
    retry_count = 0                             # retry counter

    # opening the socket using try-with-resources method
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        # i set the timeout as a second
        s.settimeout(1)
        # bind to the port
        s.bind(('', sender))
        # try to send the header first
        while header_sent is False:
            s.sendto(header.encode(), (ip, receiver))
            try:
                # as a response to the header, we need to check the ACK
                response, _ = s.recvfrom(2048)
                if response.decode() == header:
                    # if we receive the header back, it means the header reached
                    # set flag
                    header_sent = True
            except Exception:
                # header was not retrieved, resend
                retry_count += 1
                continue
        # if we have unsent packages, continue until they're complete
        while packets_sent.count(False) != 0:
            # generate the udp parcel to be sent using the first unsent packet
            parcel = p.generate_udp(*packets[last_sent])
            # send parcel
            s.sendto(parcel, (ip, receiver))
            try:
                # check if we get an ACK
                response, _ = s.recvfrom(2048)
                # read parcel nr and hash from the data
                parcel_nr, _, _, hashed = Packet.read_data_for_udp(parcel)
                # if the response is the correct hash, consider as ACK
                if response.decode() == hashed:
                    # if this is the first unsent package, set it as sent
                    # increment last_sent value by 1
                    # else, we have packets prior to this one, ignore this yet
                    if packets_sent.index(False) == parcel_nr:
                        packets_sent[parcel_nr] = True
                        last_sent += 1
            except Exception:
                # not received within time limit, retry
                retry_count += 1
                continue
        # file transfer complete
    print(f"UDP Transmission Re-transferred Packets: {retry_count}")


if __name__ == "__main__":
    args = sys.argv
    if len(args) != 6:
        print("Usage: python client.py [server-ip] [server-udp-listen] [server-tcp-listen] [client-udp-sender] [client-tcp-sender]")
    else:
        # read command line arguments
        _, ip_address, server_udp, server_tcp, client_udp, client_tcp = args
        # if non-integer values were given as port values, exit peacefully
        try:
            server_udp = int(server_udp)
            server_tcp = int(server_tcp)
            client_udp = int(client_udp)
            client_tcp = int(client_tcp)
        except Exception:
            print("Port values must be integers", file=sys.stderr)
            exit()
        tcp(ip_address, client_tcp, server_tcp)
        udp(ip_address, client_udp, server_udp)
