import os
import time
import glob
tests1=[]
tests2=[]
for root, dirs, files in os.walk('tests'):
    tests1 += glob.glob(os.path.join(root, '1_*.in'))
    tests2 += glob.glob(os.path.join(root, '2_*.in'))
def removejunk() :
	os.system("rm -rf t1p1i t1p1r t1p2")
	os.system("rm -rf results/")
p1c=len(tests1)
p2c=len(tests2)
true1=0
true2=0
true3=0
liners="----------------------------------------------------------------------"
def p1i():
	global true2
	global tests1
	#tests for part 1 iterative
	for i in xrange(p1c):
		removejunk()
		print "\tTesting Iterative Solution"
		j=str(i+1)
		try:
			os.system("mkdir results")
			os.system("gcc the1_iterative.c -Wall -ansi -pedantic-errors -o t1p1i")
		except:
			raise
			exit()
		start=time.time()
		command="./t1p1i < "+tests1[i]+" > results/1_i"+j+".out"
		os.system(command)
		end=time.time()
		expected=open(tests1[i][:-2:]+"out" , "r").read()
		outs=open("results/1_i"+j+".out" , "r").read()
		ees=expected.split("\n")
		oes=outs.split("\n")
		print liners
		if(ees == oes):
			print "\tTest %s passed for iterative solution!" % tests1[i][6:-3]
			true2+=1
		else :
			print "\tTest %s failed for iterative solution!" % tests1[i][6:-3]
			print liners
			print "\tGiven output: \t\t\tExpected output:"
			lena=max(len(ees),len(oes))
			for m in xrange(lena):
				try:
					em=ees[m]
				except:
					em=""
				try:
					om=oes[m]
				except:
					om=""
				print "\t "+om+"\t\t\t "+em
			print liners
def p1r():
	global true1
	global tests1
	#tests for part 1 recursive
	print liners
	for i in xrange(p1c):
		removejunk()
		print "\tTesting Recursive Solution"
		j=str(i+1)
		try:
			os.system("mkdir results")
			os.system("gcc the1_recursive.c -Wall -ansi -pedantic-errors -o t1p1r")
		except:
			raise
			exit()
		start=time.time()
		command="./t1p1r < "+tests1[i]+" > results/1_r"+j+".out"
		os.system(command)
		end=time.time()
		expected=open(tests1[i][:-2:]+"out" , "r").read()
		outs=open("results/1_r"+j+".out" , "r").read()
		ees=expected.split("\n")
		oes=outs.split("\n")
		print liners
		if(ees == oes):
			print "\tTest %s passed for recursive solution!" % tests1[i][6:-3]
			true1+=1
		else :
			print "\tTest %s failed for recursive solution!" % tests1[i][6:-3]
			print liners
			print "\tGiven output: \t\t\tExpected output:"
			lena=max(len(ees),len(oes))
			for m in xrange(lena):
				try:
					em=ees[m]
				except:
					em=""
				try:
					om=oes[m]
				except:
					om=""
				print "\t "+om+"\t\t\t "+em
			print liners
def p2():
	global true3
	global tests2
	for i in xrange(p2c):
		removejunk()
		j=str(i+1)
		try:
			os.system("mkdir results")
			os.system("gcc the1_part2.c -Wall -ansi -pedantic-errors -o t1p2")
		except:
			raise
			exit()
		start=time.time()
		command="./t1p2 < "+tests2[i]+" > results/2_"+j+".out"
		os.system(command)
		end=time.time()
		expected=open(tests2[i][:-2:]+"out" , "r").read()
		outs=open("results/2_"+j+".out" , "r").read()
		ees=expected.split("\n")
		oes=outs.split("\n")
		print liners
		if(ees == oes):
			print "\tTest %s passed!" % tests2[i][6:-3]
			true3+=1
		else :
			print "\tTest %s failed!" % tests2[i][6:-3]
			print liners
			print "\tGiven output: \t\t\tExpected output:"
			lena=max(len(ees),len(oes))
			for m in xrange(lena):
				try:
					em=ees[m]
				except:
					em=""
				try:
					om=oes[m]
				except:
					om=""
				print "\t "+om+"\t\t\t "+em
			print liners
def getinput():
	global tests
	try:
		tests=input()
		if(tests not in [1,2,3,4]):
			print "Please enter a valid input"
			getinput()
	except:
		print "Please enter a valid input"
		getinput()
print "Tester for 2017-2018 CENG140 Take Home Exam 1"
print liners
print "To add new tests to the tester, just copy and paste the in and out files to the tests directory."
print "Remember: Sample data for Part I  should have the following name format: 1_name.in & 1_name.out"
print "Remember: Sample data for Part II should have the following name format: 2_name.in & 2_name.out"
print "Otherwise the tests won't work properly!"
print "Enjoy the ride, and please let me know of any troubles you encounter!"
print "Mustafa Ozan Alpay - ozan.alpay@metu.edu.tr"
print liners
print "Please select which tests would you like to run:\n - 1 for Part I Iterative\n - 2 for Part I Recursive\n - 3 for Part II\n - 4 for All Parts"
tests=0
getinput()
print liners
if(tests == 1) :
	p1i()
elif(tests == 2) :
	p1r()
elif(tests == 3) :
	p2()
else :
	print "\tTests for Part I"
	p1i()
	print liners
	p1r()
	print liners
	print "\tTests for Part II"
	p2()
print liners
print "\tResults"
p1ip=true2/float(p1c)
p1ig=20*p1ip
p1rp=true1/float(p1c)
p1rg=40*p1rp
p2p=true3/float(p2c)
p2g=40*p2p
if(tests == 1 or tests == 4) :
	print "\tPart I - Iterative Solution\n"
	print "\tTotal passed tests: %d\n\tTotal tests: %d\n\tSuccess rate: %.2f%%\n\tExpected grade: %.2f\n" % (true2,p1c,p1ip*100,p1ig)
if(tests == 2 or tests == 4) :
	print "\tPart I - Recursive Solution\n"
	print "\tTotal passed tests: %d\n\tTotal tests: %d\n\tSuccess rate: %.2f%%\n\tExpected grade: %.2f\n" % (true1,p1c,p1rp*100,p1rg)
if(tests == 3 or tests == 4) :
	print "\tPart II\n"
	print "\tTotal passed tests: %d\n\tTotal tests: %d\n\tSuccess rate: %.2f%%\n\tExpected grade: %.2f\n" % (true3,p2c,p2p*100,p2g)
print liners
print "\tExpected total grade: %.2f" % (p1rg+p1ig+p2g)
