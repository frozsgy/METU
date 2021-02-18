from hashlib import sha256

from packet import Packet


def generate(file_name: str, timestamp: float, packet_count: int):
    """
    Generates header which includes metadata regarding the file to be transferred
    :param file_name: name of the file to be sent
    :param timestamp: unix timestamp
    :param packet_count: total nr of packets
    :return: header as string
    """
    # in the header, i used a string as a separator to transfer different parts of data
    header = file_name
    header += Packet.separator
    header += str(timestamp)
    header += Packet.separator
    header += str(packet_count)
    header += Packet.separator
    # in the end, i use a sha256 hash to detect errors during header transfer
    hashed = sha256(header.encode()).hexdigest()
    return header + hashed + Packet.separator


def decipher(data: bytes):
    """
    Deciphers received header metadata to act accordingly
    :param data: header data
    :return: Tuple of file name, timestamp, packet count, data if valid, else False
    """
    try:
        # split received data according to the separator
        headers = data.split(Packet.separator.encode())
        # get file name, timestamp, packet count and checksum
        file_name = headers[0].decode()
        timestamp = float(headers[1].decode())
        packet_count = int(headers[2].decode())
        hashed = headers[3].decode()
        # create the data to be checksummed
        to_be_hashed = file_name + Packet.separator + headers[1].decode() + Packet.separator + headers[
            2].decode() + Packet.separator
        # calculate checksum
        hashed_check = sha256(to_be_hashed.encode()).hexdigest()
        # check if calculated checksum matches the transferred
        if hashed == hashed_check:
            # use the remaining data as the actual data
            # useful with tcp, since it's a stream
            data = headers[4]
            return file_name, timestamp, packet_count, data
        else:
            return False
    except Exception:
        return False
