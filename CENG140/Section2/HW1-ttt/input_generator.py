import os
import random


# To compare input outputs with the original ttt binary


for queue in range(200):
    file_content = ""

    # Generate randomly numbers from 0 to 10, and test all of them(use 100 to ensure the game should end, otherwise infinite loop occurs)
    for i in range(1000):
        file_content = file_content + str(random.randrange(10))
        file_content = file_content + '\n'
        
    # Check if all numbers are added
    for i in range(8):
        if not str(i) in file_content:
            print "asdkaslkdjaslkjd"
            break
    
        my_file = open("generator_output/input_file_" + str(queue), "w")
        my_file.write(file_content)
        my_file.close();
    
    
