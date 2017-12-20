###############################################################################
#                                                                             #
#       METU CENG                                                             #
#       2017-2018 CENG111                                                     #
#       TAKE HOME EXAM - 2                                                    #
#       MUSTAFA OZAN ALPAY                                                    #
#       2309615                                                               #
#       Version: 1.1.2 (2018-12-11 21:42)                                     #
#                                                                             #
###############################################################################
# Let's define our epsilon value, possible dual combinations and functions we are going to use later
# constants go here
diff=float(0.001)
c6=([1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,1],[3,2],[3,3])
c7a=([1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4],[3,1],[3,2],[3,3],[3,4])
c7b=([1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,1],[3,2],[3,3],[4,1],[4,2],[4,3])
c8=([1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,3],[4,4])
# helper functions go here
def line(x,x1,y1,m) :
    # returns y value for any given linear function with slope, x, x1, y1 values
    # y - y1 = m * (x - x1)
    y=float(m)*(float(x)-float(x1))+float(y1)
    return y
def line5x(y,x1,x2,y1,y2) :
    # finds the missing x value according to the other components of the line
    y=float(y)
    x1=float(x1)
    x2=float(x2)
    y1=float(y1)
    y2=float(y2)
    x=((x2-x1)/(y2-y1))*(y-y1)+x1
    return x
def findn(x,y,m) :
    # returns n value for any linear function when given in y = m*x + n format
    n=float(y)-float(m)*float(x)
    return n
def slope(y2,y1,x2,x1) :
    # calculates the slope of the line connecting any given two points
    dx=float(x2)-float(x1)
    dy=float(y2)-float(y1)
    if(dx == 0.0):
        # if the line is x=a type, return asym as the slope.
        return 'asym'
    else :
        return dy/dx
def commonroot(a) :
    # finds the intersection point of two sets of two different points.
    # let's calculate the slopes of each line lies between the dots.
    m1=slope(a[0][1],a[1][1],a[0][0],a[1][0]) #slope: y2,y,x2,x
    m2=slope(a[2][1],a[3][1],a[2][0],a[3][0])
    if(m1 == m2) :
        commonx='AAA'
        commony='AAA'
    else :
        if(m1!='asym' and m2 !='asym') :
            # if both of the lines have a real slope
            commonx=(findn(a[2][0],a[2][1],m2)-findn(a[0][0],a[0][1],m1))/(m1-m2)
            commony=m1*commonx+findn(a[0][0],a[0][1],m1)
        elif(m2 == 'asym') :
            # if line2 is in x=a format
            commonx=a[2][0]
            commony=m1*commonx+findn(a[0][0],a[0][1],m1)
        elif(m1 == 'asym') :
            # if line1 is in x=a format
            commonx=a[0][0]
            commony=commonx*m2+findn(a[2][0],a[2][1],m2)
        # check if the common root is within the range of the points
        buyukx1=max(a[0][0],a[1][0])
        kucukx1=min(a[0][0],a[1][0])
        buyuky1=max(a[0][1],a[1][1])
        kucuky1=min(a[0][1],a[1][1])
        buyukx2=max(a[2][0],a[3][0])
        kucukx2=min(a[2][0],a[3][0])
        buyuky2=max(a[2][1],a[3][1])
        kucuky2=min(a[2][1],a[3][1])
        # If the common root is not within the range of the points, return them as AAA,AAA, as we are going to remove them later.
        if (commonx < (kucukx1-diff) or  commonx > (buyukx1+diff) or commonx < (kucukx2-diff) or commonx > (buyukx2+diff) or commony < (kucuky1-diff) or  commony > (buyuky1+diff) or commony < (kucuky2-diff) or commony > (buyuky2+diff)):
            commonx='AAA'
            commony='AAA'
    return (commonx,commony)
def icerde(polygon, x, y):
    # apply even-odd rule to find out if the point falls inside the polygon
    result=False
    a=0
    b=len(polygon)-1
    for a in range(0,len(polygon)) :
        if ((polygon[a][1] > y) != (polygon[b][1] > y)) :
            if (x < line5x(y,polygon[a][0],polygon[b][0],polygon[a][1],polygon[b][1])) :
                if(result == False) : result = True
                elif(result == True) : result = False
        b=a
    return result
def duzlestir(a):
    # let's convert the nested lists into regular ones
    sonuc = []
    for c in a:
        if (type(c) == list):
            for b in c: sonuc.append(b)
        else:
            sonuc.append(c)
    return sonuc
def c2float(a) :
    say=len(a)
    sonuc=[]
    for j in range (0,say) :
        #convert all to float
        b=float(a[j][0])
        c=float(a[j][1])
        sonuc.append((b,c))
    return sonuc
def removeduplicates(a):
    a=list(set(a))
    say=len(a)
    fin=[(a[0][0],a[0][1])]
    for i in range(1,say):
        #check if exists in the fin list, if not add.
        sayf=len(fin)
        ax=a[i][0]
        ay=a[i][1]
        # kac is a list of boolean items, which has the value "True" for different items, and "False" for same items.
        kac=[]
        for j in range(0,sayf):
            ex=fin[j][0]
            ey=fin[j][1]
            if (abs(ax-ex) > diff or abs(ay-ey) > diff):
                kac.append(True)
            else :
                kac.append(False)
        # If there is not a single item that we can consider the same, append the item to the list.
        if(kac.count(False) < 1) :
            fin.append((ax,ay))
    return fin
def finalreturn(a) :
    if(len(a) > 0) :
        a=removeduplicates(a)
    if(len(a) < 3) :
        a=[]
    return a
# main function
def minority_shape_intersect(polygon1,polygon2) :
    polygon1=c2float(polygon1)
    polygon2=c2float(polygon2)
    p1kenar=len(polygon1) # count edges of polygon 1
    p2kenar=len(polygon2) # count edges of polygon 2
    toplamkenar=p1kenar+p2kenar
    totalcomb=p1kenar*p2kenar
    roots=[]
    result=[]
    if (toplamkenar == 6) :
        # both are triangles
        # let's retrieve the corner coordinates
        allcorners=duzlestir([polygon1,polygon2])
        for j in range(0,totalcomb):
            # let's compare
            combination=c6[j]
            # 1st edge p1-p2, 2nd edge p2-p3, 3rd edge p3-p1
            which1=combination[0] # 1,2,3
            which2=combination[1] # 1,2,3
            cx1,cy1=polygon1[which1-1]
            cx2,cy2=polygon1[which1%3]
            cx3,cy3=polygon2[which2-1]
            cx4,cy4=polygon2[which2%3]
            checker=[(cx1,cy1),(cx2,cy2),(cx3,cy3),(cx4,cy4)]
            roots.append(list(commonroot(checker)))
        for k in range(0,toplamkenar):
            # compare each corner if it falls inside the other polygon
            # first 3 polygon1 items, last 3 polygon2 items
            if (k < 3) :
                if(icerde(polygon2,allcorners[k][0],allcorners[k][1])) :
                    yeniortak=(allcorners[k][0],allcorners[k][1])
                    roots.append(yeniortak)
            else :
                if(icerde(polygon1,allcorners[k][0],allcorners[k][1])) :
                    yeniortak=(allcorners[k][0],allcorners[k][1])
                    roots.append(yeniortak)
        pseudosay=len(roots)
        for u in range(0,pseudosay) :
            zero=['AAA','AAA']
            if(roots[u] != zero) :
                result.append(tuple(roots[u]))
        result=finalreturn(result)
        return result
    elif (toplamkenar == 7) :
        # one of them is a triangle, the other is a quadrilateral
        if(p1kenar == 4) :
            # the reverse order of the regular one, reverse it and move on
            midpolygon=polygon2
            polygon2=polygon1
            polygon1=midpolygon
        allcorners=duzlestir([polygon1,polygon2])
        for j in range(0,totalcomb):
            # let's compare
            combination=c7a[j] # (1,2) -> 1st edge from the first polygon, 2nd edge from the second polygon
            # 1st edge p1-p2, 2nd edge p2-p3, 3rd edge p3-p1
            which1=combination[0] # 1,2,3
            which2=combination[1] # 1,2,3,4
            cx1,cy1=polygon1[which1-1]
            cx2,cy2=polygon1[which1%3]
            cx3,cy3=polygon2[which2-1]
            cx4,cy4=polygon2[which2%4]
            checker=[(cx1,cy1),(cx2,cy2),(cx3,cy3),(cx4,cy4)]
            roots.append(list(commonroot(checker)))
        for k in range(0,toplamkenar):
            # compare each corner if it falls inside the other polygon
            # first 3 polygon1 items, last 4 polygon2 items
            if (k < 3) :
                if(icerde(polygon2,allcorners[k][0],allcorners[k][1])) :
                    yeniortak=(allcorners[k][0],allcorners[k][1])
                    roots.append(yeniortak)
            else :
                if(icerde(polygon1,allcorners[k][0],allcorners[k][1])) :
                    yeniortak=(allcorners[k][0],allcorners[k][1])
                    roots.append(yeniortak)
        pseudosay=len(roots)
        for u in range(0,pseudosay) :
            zero=['AAA','AAA']
            if(roots[u] != zero) :
                result.append(tuple(roots[u]))
        result=finalreturn(result)
        return result
    elif (toplamkenar == 8) :
        # both are quadrilaterals
        allcorners=duzlestir([polygon1,polygon2])
        for j in range(0,totalcomb):
            # let's compare
            combination=c8[j] #
            # 1st edge p1-p2, 2nd edge p2-p3, 3rd edge p3-p1
            which1=combination[0] # 1,2,3,4
            which2=combination[1] # 1,2,3,4
            cx1,cy1=polygon1[which1-1]
            cx2,cy2=polygon1[which1%4]
            cx3,cy3=polygon2[which2-1]
            cx4,cy4=polygon2[which2%4]
            checker=[(cx1,cy1),(cx2,cy2),(cx3,cy3),(cx4,cy4)]
            roots.append(list(commonroot(checker)))
        for k in range(0,toplamkenar):
            # compare each corner if it falls inside the other polygon
            # first 4 polygon1 items, last 4 polygon2 items
            if (k < 4) :
                if(icerde(polygon2,allcorners[k][0],allcorners[k][1])) :
                    yeniortak=(allcorners[k][0],allcorners[k][1])
                    roots.append(yeniortak)
            else :
                if(icerde(polygon1,allcorners[k][0],allcorners[k][1])) :
                    yeniortak=(allcorners[k][0],allcorners[k][1])
                    roots.append(yeniortak)
        pseudosay=len(roots)
        for u in range(0,pseudosay) :
            zero=['AAA','AAA']
            if(roots[u] != zero) :
                result.append(tuple(roots[u]))
        result=finalreturn(result)
        return result
    else:
        # wrong input
        return 'Please type only triangles and/or quadrilaterals.'
#eof
