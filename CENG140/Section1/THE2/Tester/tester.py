import os
import time
import glob
import sys


RED   = "\033[1;31m"
GREEN = "\033[0;32m"
RESET = "\033[0;0m"
BOLD = '\033[1m'
OKBLUE = '\033[94m'
FAIL = '\033[91m'


tests1=[]

true2=0

liners="----------------------------------------------------------------------"

for root, dirs, files in os.walk('tests'):
	tests1+=glob.glob(os.path.join(root, '*.in'))

def removejunk() :
	os.system("rm -rf the2")
	os.system("rm -rf results/")

no_of_inputs=len(tests1)

if(no_of_inputs== 0) :
	print "\n\tError: No files found in tests folder.\n Please make sure that you have the I/O pairs in the tests folder, and the folder & the files have proper CHMOD permissions.\n"
	exit()

def test():
	global true2
	global tests1
	try:
		removejunk()
		os.system("mkdir results")
		os.system("gcc the2.c -Wall -ansi -pedantic-errors -o the2")

	except:
		raise
		exit()
	for i in xrange(no_of_inputs):
		j=str(i+1)
		start=time.time()
		command="./the2 < "+tests1[i]+" > results/"+j+".out"
		os.system(command)
		end=time.time()
		expected=open(tests1[i][:-2:]+"out" , "r").read()
		outs=open("results/"+j+".out" , "r").read()
		ees=expected.split("\n")
		oes=outs.split("\n")
		print liners
		if(ees == oes):
			sys.stdout.write(GREEN)
			sys.stdout.write(BOLD)
			print "\tTest %s passed !" % tests1[i][6:-3]
			sys.stdout.write(RESET)
			true2+=1
		else :
			sys.stdout.write(RED)
			sys.stdout.write(BOLD)
			print "\tTest %s failed !" % tests1[i][6:-3]
			sys.stdout.write(RESET)
			print '\n'
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

				print "\t%s\t\t\t%s" % (om.ljust(lena, " "), em)
				#print "\t "+om+"\t\t\t "+em
			print liners

os.system('clear')
print "\nTester for 2017-2018 CENG140 Take Home Exam 2"
print liners
print "To add new tests to the tester, just copy and paste the in and out files to the tests directory."
print "Remember: I/O pairs should have the following name format: name.in & name.out"
print "Otherwise the tests won't work properly!"
print "Enjoy the ride, and please let us know of any troubles you encounter!"
print "Alperen Caykus && M. Ozan Alpay - alperen.caykus@metu.edu.tr && ozan.alpay@metu.edu.tr"
print liners
print "\tTesting..."
print "\tResults : "
test()
point_per_test=true2/float(no_of_inputs)
grade=100*point_per_test

print liners

if(grade>=30.00):
	sys.stdout.write(OKBLUE)
	sys.stdout.write(BOLD)
	print "\t GRADE: %.2f" % grade

else:
	sys.stdout.write(FAIL)
	sys.stdout.write(BOLD)
	print "\t GRADE: %.2f" % grade





sys.stdout.write(RESET)
