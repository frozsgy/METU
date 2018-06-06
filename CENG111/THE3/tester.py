import random
import time
import the3

wrong = False

def design(x,y,karar):
    #x: length of the string, y: extra lines
    allow="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    durum=False
    while durum == False :
        liste=[]
        for i in range(0,x):
            v=''
            for j in range(0,x):
                rand=random.randint(0,25)
                v+=allow[rand]
            liste.append(v)
        satir=tuple(liste)
        liste2=[]
        for j in range(0,x):
            v=''
            for i in range(0,x):
                v+=liste[i][j]
            liste2.append(v)
        sutun=tuple(liste2)
        liste3=[]
        for i in range(0,y):
            v=''
            for j in range(0,x):
                rand=random.randint(0,25)
                v+=allow[rand]
            liste3.append(v)
        ekstra=tuple(liste3)
        say1=len(satir)
        say2=len(sutun)
        say3=len(ekstra)
        if(say1+say2+say3 == len(set(satir+sutun+ekstra))) and (karar in  ["G", "g"]) :
            durum=True
            lists=liste+liste2+liste3
            random.shuffle(lists)
            print "\n   Input               : ",
            print lists
            print "\n   Result (as rows)    : ",
            print liste
            print "\n   Result (as columns) : ",
            print liste2
            return "\n   That's all folks!"
        elif karar in ["MA", "ma", "mA", "Ma", "a", "A"]:
            durum=True
            start_time = time.time()
            lists=liste+liste2+liste3
            random.shuffle(lists)
            print "   Testing with %2d" % x, "x %2d" % x, " and %2d" % y, "extras                       ",
            out1 = the3.place_words(lists)
            execution_time = time.time() - start_time
            out2 = True
            for in_out in out1:
                if lists.count(in_out) == 0:
                    out2 = False
            if out2:
                print "   Passed! Execution time : ", execution_time
            else:
                print "   FAILED!"
                global wrong
                wrong = True
                print "   Input : ", lists
                print "\n   Possible output : ", liste
                print "\n   Program output : ", out1

def getInput() :
    karar = raw_input("   Auto-Control or Generate String or Multi-Auto-Control (A/G/MA): ")
    if karar in ["A", "a", "G", "g"]:
        s=input('   Please enter the length of your strings: ')
        e=input('   Please enter how many extra strings you\'d like: ')
        print " "
        design(s, e, karar)
    elif karar in ["MA", "ma", "mA", "Ma"]:
        max_i = input("   Total number of tests: ")
        print " "
        for i in range(max_i):
            design(random.randint(2, 70), random.randint(0, 50), karar)
        if wrong:
            print "   There is at least a wrong result :("
        print "   Done!"
    else:
        print "   Please try again\n"
        getInput()

print "\n   Automated Random Input Generator & Tester for CENG111 THE3 - by Mustafa Ozan Alpay"
print "   Multi-Auto-Control was developed by Ahmet Fatih Eser\n"
getInput()
