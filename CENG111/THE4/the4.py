###############################################################################
#                                                                             #
#       METU CENG                                                             #
#       2017-2018 CENG111                                                     #
#       TAKE HOME EXAM - 4                                                    #
#       MUSTAFA OZAN ALPAY                                                    #
#       2309615                                                               #
#       Version: 1.1.0 (2018-01-21 23:06)                                     #
#                                                                             #
###############################################################################
# helper functions
def isleaf(item) :
    # checks if the given tree has children, returns boolean
    return (len(item) == 2)
def sumofforces(tree) :
    # returns the sum of forces below the parent of the tree.
    say=len(tree)
    if(isleaf(tree)) :
        return 0
    f=0
    for i in xrange(2,say) :
        f+=tree[i][1]
    return f
def height(tree,wanted,l) :
    # finds the height of the wanted item in a tree
    if(tree[0] == wanted) :
        return l+1
    firstgen=tree[2:]
    say=len(firstgen)
    for i in xrange(say) :
        temp=firstgen[i]
        temp2=height(temp,wanted,l+1)
        if(temp2 != None) :
            return temp2
def createDict(tree) :
    # creates a dictionary from a tree
    troopers=[]
    troopers.append({'name': tree[0], 'force' : tree[1], 'height' : 1, 'parent' : ''})
    firstgen=tree[2:]
    say=len(firstgen)
    for i in xrange(say) :
        temp=firstgen[i]
        temp2=createDict_recursive(temp,1,tree[0])
        if(temp2 != None) :
            if(type(temp2) == list) :
                troopers.extend(temp2[:])
            else :
                troopers.append(temp2)
    return troopers
def createDict_recursive(tree,l,parent) :
    # recursive helper function of createDict
    if (isleaf(tree)) :
        return {'name': tree[0], 'force' : tree[1], 'height' : l+1, 'parent' : parent}
    appendable=[{'name': tree[0], 'force' : tree[1], 'height' : l+1, 'parent' : parent}]
    nextgen=tree[2:]
    say=len(nextgen)
    for i in xrange(say) :
        temp3=createDict_recursive(nextgen[i],l+1,tree[0])
        if(type(temp3) == list) :
            appendable.extend(temp3[:])
        else :
            appendable.append(temp3)
    return appendable
def createDictReverse(tree) :
    # creates a dictionary based on the reversed-height system
    td=createDict(tree)
    temp=sorted(td[:],key=dictHeight)
    a=temp[-1]['height'] #max height
    b=255-a #256 is the bias we use to reverse the height
    for i in xrange(len(td)) :
        td[i]['height']=abs(td[i]['height']-256)
        td[i]['height']-=b
    return td
def nameDict(tree) :
    # creates a dictionary with names only
    dictionary=createDict(tree)
    names=[]
    say=len(dictionary)
    for i in xrange(say) :
        names.append(dictionary[i]['name'])
    return names
def bias(a,h) :
    # a is the maximum depth of the tree
    b=255-a #256 is the bias we use to reverse the height
    return abs(h-256)-b
def dictHeight(troop) :
    # returns the height of a given item in the dictionary
    return troop['height']
def c1_categorizer(tree) :
    # main helper function for constraint 1
    preC1list=createDict(tree)
    temp=sorted(preC1list[:],key=dictHeight)
    temps=str(tree)
    say=len(preC1list)
    change=1
    for i in xrange(say) :
        if(change < 2) :
            current=preC1list[i]
            h=current['height']
            f=current['force']
            n=current['name']
            for j in xrange(i+1, say) :
                if(change < 2) :
                    ch=preC1list[j]
                    h2=ch['height']
                    f2=ch['force']
                    n2=ch['name']
                    #print 'checking %s (h: %d f: %d) with %s (h: %d f: %d)' % (n,h,f,n2,h2,f2)
                    if(h > h2 and f > f2) :
                        #print 'changing %s (%d) with %s (%d)' % (n,h,n2,h2)
                        temps=temps.replace("'%s', %d" % (n,f),"'%s',AAA %d" % (n2,f2))
                        temps=temps.replace("'%s', %d" % (n2,f2),"'%s', %d" % (n,f))
                        temps=temps.replace("'%s',AAA %d" % (n2,f2),"'%s', %d" % (n2,f2))
                        change+=1
                    elif(h2 > h and f2 > f) :
                        #print 'changing %s (%d) with %s (%d)' % (n,h,n2,h2)
                        temps=temps.replace("'%s', %d" % (n,f),"'%s',AAA %d" % (n2,f2))
                        temps=temps.replace("'%s', %d" % (n2,f2),"'%s', %d" % (n,f))
                        temps=temps.replace("'%s',AAA %d" % (n2,f2),"'%s', %d" % (n2,f2))
                        change+=1
    return eval(temps)
adoptable=[]
def c2_categorizer(treex,h) :
    # main helper function for constraint 2
    global adoptable
    tree=treex[:]
    preC2list=createDict(tree)
    preC2listR=createDictReverse(tree)
    temp=sorted(preC2listR[:],key=dictHeight)
    temp2=sorted(preC2list[:],key=dictHeight)
    currentMaxHeight=temp2[::-1][-1]['height']
    if(currentMaxHeight < h) :
        # start recursion -  bds
        children=tree[2:]
        for i in xrange(2,len(tree)) :
            tree[i]=c2_categorizer(tree[i][:],h-1)
        if(currentMaxHeight == h-1) :
            if(tree[1] > sumofforces(tree)) :
                # adopt children until it's fine
                remaining=tree[1]-sumofforces(tree)
                waitingList=candidates(adoptable,siblingCandidates(tree[2:]))
                tree=adopt(tree,remaining,waitingList)
        return tree
    elif(currentMaxHeight == h) :
        # kill children
        children=tree[2:]
        say2=len(children)
        for i in xrange(say2) :
            adoptable.append({'parent' : tree[0], 'children': children[i][:2]})
        temp=tree[0:2][:]
        return temp
    else :
        return tree
def candidates(children,parent) :
    # selects available children from all available children list according to the parents
    # children: dictionary
    # parents: tuple (a,b,c,d)
    candidates=[]
    if (children == None) :
        return []
    say=len(children)
    for i in xrange(say) :
        candidate=children[i]
        if (candidate['parent'] in parent) :
            candidates.append(candidate['children'][:])
    return candidates
def siblingCandidates(siblings) :
    # creates a tuple of names from a nested list
    say=len(siblings)
    sibl=[]
    for i in xrange(say) :
        sibl.append(siblings[i][0])
    return tuple(sibl)
def candidateSums(members) :
    # calculates the sum of forces from a nested list
    say=len(members)
    f=0
    if(members == []) :
        return 0
    for i in xrange(say) :
        f+=members[i][1]
    return f
def getForce(x) :
    # returns the force value of a node
    return x[1]
def getForceDict(x) :
    # returns the force value of a node in a dictionary
    return x['force']
def findForce(alt,force) :
    # returns the selection with maximum sum of forces from possible adoption options
    say=len(alt)
    temp=[]
    for i in xrange(say) :
        if(alt[i]['force'] <= force) :
            temp.append(alt[i])
    candidates=sorted(temp,key=getForceDict)
    return candidates[-1]['members']
def maxforce(candidates2) :
    # creates all possible force sums from a list of candidates, returns dictionary
    alternatives=maxforce_recursive([], sorted(candidates2, key=getForce))
    say=len(alternatives)
    fin=[]
    for i in xrange(say) :
        temp=alternatives[i][:]
        tempf=candidateSums(temp)
        fin.append({'force' : tempf, 'members' : temp})
    return fin
def maxforce_recursive(active, siblings2) :
    # recursive helper function of maxforce
    if (siblings2 != []) :
        te=active[:]
        te+=[siblings2[0]]
        p1=maxforce_recursive(active[:], siblings2[1:])
        p2=maxforce_recursive(te, siblings2[1:])
        perm=p1+p2
        return perm
    else :
        return [active]
def adopt(tree,remaining,candidates) :
    # adopts the maximum possible option to a parent during constraint 2
    if(candidateSums(candidates) <= remaining) :
        tree+=candidates
    else :
        b=maxforce(candidates)
        adopting=findForce(b,remaining)
        tree+=adopting
    return tree
def deadOnes(initial,final) :
    # creates the list of executed commanders
    first=nameDict(initial)
    last=nameDict(final)
    return list(set(first)-set(last))
# main function
def help_ben_solo(troopers,height) :
    #return a tuple with two subitems, first the new organization chart as a nested List
    #second as the executed members as a list
    first=troopers[:]
    preC2listR=createDictReverse(troopers)
    temp=sorted(preC2listR[:],key=dictHeight)
    currentMaxHeight=temp[-1]['height']
    biased=bias(currentMaxHeight,height)
    for i in xrange(len(troopers)) :
        troopers=c1_categorizer(troopers)
    troopers=c2_categorizer(troopers,biased)
    if(type(troopers) == list) :
        troopers=(troopers[:],deadOnes(first,troopers[:]))
    global adoptable
    adoptable=[]
    return troopers
#eof
