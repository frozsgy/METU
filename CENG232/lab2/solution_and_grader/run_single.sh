# ./run_single.sh circ_file_name
# ./run_single.sh e1234567.circ
# ./run_single.sh some\ dir/another\ dir\ submission_file_/e1234567.circ

java -jar logisim-ceng232-20090616.jar -grader grader-hw2.properties "$1" 2>&1 | tee eval.out

echo
echo "NUM PASS:"
cat eval.out | grep -c PASS
echo "NUM FAIL:"
cat eval.out | grep -c FAIL
echo "These numbers also include 'CHIPS PASS', 'CHIPS FAIL', do not forget to -1"

rm eval.out