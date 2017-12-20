import random

def design(x,y):
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
        if(say1+say2+say3 == len(set(satir+sutun+ekstra))) :
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
print "\n"
print "   Automated Random Input Generator for CENG111 THE3 - by Mustafa Ozan Alpay"
print "\n"

###
# sample usage: print design(a,b)
# a: the length of the strings
# b: extra strings
##
# let a=3, b=1
# input: ["ALI", "SIN", "ASI", "LIR", "IRI", "INI", "KAR"])
# output: ["ALI", "SIN", "IRI"]
# another example
# Input:  ['UIN', 'QVE', 'GLU', 'JDI', 'GJT', 'LDW', 'TWN']
# Result:  ['GLU', 'JDI', 'TWN']

#print design(3,1)
s=input('   Please enter the length of your strings: ')
e=input('   Please enter how many extra strings you\'d like: ')
print design(s,e)
