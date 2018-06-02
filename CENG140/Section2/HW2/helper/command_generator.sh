#!/bin/bash

# Use : command_generator.sh number_of_generations
# Outputs the 'commands' file under data folder
# Argument numbers etc. is arbitrary, so try with very big numbers


################### NOTES ###################
# This may or may not work since sometimes both answers are correct and depend on the algorithm.

output_file="data/commands"

number_of_commands=9 # register, path, etc.
number_of_users=7 # how many different users will be for the first argument
number_of_users_iki=100 # second argument count, increase to decrease the probability to have a second argument
number_of_commands_uc=3 # sort icin

sayici=0

while [ $sayici -lt $1 ]
do
    sayici=$((sayici+1))
    
    # Command generator
    my_rand=$RANDOM
    my_rand=$(($my_rand%$number_of_commands))
    case $my_rand in
        0)
            printf register >> $output_file
            ;;
        1)
            printf delete >> $output_file
            ;;
        2)
            printf find >> $output_file
            ;;
        3)
            printf connect >> $output_file
            ;;
        4)
            printf disconnect >> $output_file
            ;;
        5)
            printf path >> $output_file
            ;;
        6)
            #printf list >> $output_file # Alltaki case icerisinde aciklanan sebepten dolayi
            printf "\n" >> $output_file
            continue
            ;;
        7)
            printf help >> $output_file
            printf "\n" >> $output_file
            continue
            ;;
        8)  
            my_rand=$RANDOM
            my_rand=$(($my_rand%$number_of_commands_uc))
            printf sort >> $output_file
            case $my_rand in
                #0)
                    #printf " abc" >> $output_file # Malesef bu da calismiyor, cunku hocanin kodu sort edildikten sonra register edilen uyeleri bir yukari bir asagi yaziyor, ben iste direk ucuna ekliyorum. O yuzden list dedigimiz sey ayni ciktiyi vermiyor.
                    #;;
                #1)
                    #printf " pop" >> $output_file # Disable it because with same number of followers, the output will change due to reason I do not understand
                 #   ;;
                2)
                    printf " baska_birsey" >> $output_file
                    ;;
            esac
            my_rand=$RANDOM
            my_rand=$(($my_rand%$number_of_commands_uc))
            case $my_rand in
                0)
                    printf " asc" >> $output_file
                    ;;
                1)
                    printf " desc" >> $output_file
                    ;;
                2)
                    printf " baska_birsey" >> $output_file
                    ;;
            esac
            printf "\n" >> $output_file
            continue
            ;;
            
    esac
    
    # Argument generator(first argument)
    my_rand=$RANDOM
    my_rand=$(($my_rand%$number_of_users))
    case $my_rand in
        0)
            printf " a" >> $output_file
            ;;
        6)
            printf " b" >> $output_file
            ;;
        2)
            printf " c" >> $output_file
            ;;
        3)
            printf " d" >> $output_file
            ;;
        4)
            printf " e" >> $output_file
            ;;
        5)
            printf " f" >> $output_file
            ;;
        1*)
            printf " deneme$my_rand" >> $output_file # maxUserNameLength test
            ;;
            # Do nothing for case $number_of_users
            
    esac
    # Argument generator(second argument)
    my_rand=$RANDOM
    my_rand=$(($my_rand%$number_of_users_iki))
    case $my_rand in
        0)
            printf " a" >> $output_file
            ;;
        1)
            printf " b" >> $output_file
            ;;
        2)
            printf " c" >> $output_file
            ;;
        3)
            printf " d" >> $output_file
            ;;
        4)
            printf " e" >> $output_file
            ;;
        5)
            printf " f" >> $output_file
        
            # Do nothing for case $number_of_users
            
    esac
    printf "\n" >> $output_file
done

echo quit >> $output_file

exit 0
    
