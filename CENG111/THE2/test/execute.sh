rm -f results
for i in `ls io`; 
do 
	echo $i &>> results;
	python check.py < io/$i &>> results;
done

cat results | grep -i success | wc -l
