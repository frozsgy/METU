Example test for the iterative part

You can generate your outputs using commands below. Make sure to execute commands in a directory that contains given i/o folders and your binaries.

mkdir part1_iterative
mkdir diff_part1_iterative

for j in {0..99}; do  echo $j; ./the1_iterative < part1_input/input_$j.inp &> part1_iterative/output_$j.out; done

for j in {0..99}; do  diff -w part1_output/output_$j.out part1_iterative/output_$j.out &> diff_part1_iterative/$j.txt;  done

This is an example for iterative part. You can alter executables and folder names in order to generate your outputs and differences for recursive part and part2. As a result, directory name part1_iterative will contain your outputs and directory named diff_part1_iterative will contain the differences between your output and the correct output. If there is no difference, you will get a point from that i/o pair.

As you will see in the shared i/o, there are two different i/o pairs for part1. One contains large fields (up to 100X100) and the small one contains fields between 2x2 and 10x10. 