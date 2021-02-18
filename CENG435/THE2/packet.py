from hashlib import sha256
from math import ceil
from sys import stderr
from time import time


class Packet:
    __data = None  # file data
    __total_size = 0  # size in bytes
    __data_size = 750  # data per packet
    __file_name = ""  # file name
    packet_count = 0  # how many packets will this data be split
    separator = "[4-8-15-16-23-42]"  # separator

    def __init__(self, file_name: str):
        """
        :param file_name: file name to be read
        """
        try:
            # read file as bytes
            self.__file_name = file_name
            file_pointer = open(file_name, "rb")
            self.__data = file_pointer.read()
            # get file size
            self.__total_size = len(self.__data)
            # calculate packet count
            self.packet_count = ceil(self.__total_size / self.__data_size)
        except Exception:
            print(f"Cannot read file: {file_name}", file=stderr)

    def generate_udp(self, parcel: bytes, parcel_nr: int):
        """
        Function to generate UDP data parcels
        :param parcel: data to be transferred
        :param parcel_nr: parcel nr
        :return: package
        """
        # calculate a sha256 hash using the data
        hashed = sha256(parcel).hexdigest()
        # get the current timestamp
        timestamp = time()
        # calculate a sha256 hash using timestamp
        hashed_time = sha256(str(timestamp).encode()).hexdigest()
        # calculate a sha256 hash using parcel number
        hashed_parcel_nr = sha256(str(parcel_nr).encode()).hexdigest()
        head = (str(parcel_nr) + self.separator + str(timestamp) + self.separator).encode()
        foot = (self.separator + hashed + self.separator + hashed_time + self.separator + hashed_parcel_nr + self.separator).encode()
        # merge parcel number, timestamp, data, hashed data, hashed timestamp, hashed parcel nr
        data = head + parcel + foot
        return data

    def split_data_for_udp(self):
        """
        Splits the data into packages
        :return: generator of tuple with data split according to the packet sizes and parcel number
        """
        for i in range(self.packet_count):
            yield self.__data[i * self.__data_size: (i + 1) * self.__data_size], i

    @staticmethod
    def read_data_for_udp(data: bytes):
        """
        Parses received data through UDP
        :param data: data to be read
        :return: Tuple of parcel number, timestamp, parcel and hash if valid, else False
        """
        try:
            # split data using separator
            data_array = data.split(Packet.separator.encode())
            # get parcel nr, timestamp, data
            parcel_nr = int(data_array[0].decode())
            timestamp = float(data_array[1].decode())
            parcel = data_array[2]
            # get data, timestamp, parcel nr hash
            hashed = data_array[3].decode()
            hashed_timestamp = data_array[4].decode()
            hashed_parcel_nr = data_array[5].decode()
            # calculate hashes for time, parcel and parcel nr
            hashed_time = sha256(data_array[1]).hexdigest()
            hashed_calculated = sha256(parcel).hexdigest()
            hashed_parcel_nr_calculated = sha256(str(parcel_nr).encode()).hexdigest()
            # if hashes match, transferred data is valid
            if hashed == hashed_calculated and hashed_time == hashed_timestamp and hashed_parcel_nr == hashed_parcel_nr_calculated:
                return parcel_nr, timestamp, parcel, hashed
            else:
                return False
        except Exception:
            return False

    def split_data(self):
        """
        :return: generator of data split according to the packet sizes
        """
        for i in range(self.packet_count):
            data_packet = self.__data[i * self.__data_size: (i + 1) * self.__data_size]
            yield data_packet
