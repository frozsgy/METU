#!/bin/bash

# Specify how many test will be done
# Use : test.sh number_of_tests
# Decrease if there are a lot of differences
# Increase if no difference is found
# To change test parameters, refer to helper/command_generator.sh
# Give -1 to number_of_tests to use the same data as before

number_of_tests=100

mkdir data &> /dev/null

if [ -z $1 ]
then
    echo "Trial numbers are not given, taking default. $number_of_tests"
else
    number_of_tests=$1
fi

if [ $number_of_tests -ne -1 ]
then
    # Clean
    rm data/commands

    # Generate commands
    bash helper/command_generator.sh $number_of_tests
fi
    
# Test and compare
./cb_hazir 5 5 5 < data/commands > data/hazir_output
timeout 10 ./cb 5 5 5 < data/commands > data/yazilmis_output



diff_out=$(diff data/hazir_output data/yazilmis_output -I "* by")
state=$?


if [ $state -eq 0 ]; then
    echo "No differences found, increase the trial number and try again for better convergence..."
    exit 0
else
    diff data/hazir_output data/yazilmis_output -I "* by"
    exit 1
fi
    
