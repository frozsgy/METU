###############################################################################
#                                                                             #
#       METU CENG                                                             #
#       2017-2018 CENG111                                                     #
#       TAKE HOME EXAM - 3                                                    #
#       MUSTAFA OZAN ALPAY                                                    #
#       2309615                                                               #
#       Version: 1.1.5 (2017-12-26 22:08)                                     #
#                                                                             #
###############################################################################
# helper functions go here
def board_ok(x,z):
    # check if the result list is existing in the main list
    say=len(x)
    if(x == []) : return False
    tempx=columnist(x)
    return set(tempx).issubset(set(z))
def manycheck(inp,rem):
    # this function checks if the list tried so far is available in the corpus
    # if disabled, the backtracking will become brute-force
    n=len(inp[0])
    l=len(inp)
    rem=[x[:l] for x in rem]
    c=[]
    for i in xrange(0,n):
        temp=inp[0][i]
        for j in xrange(0,l-1):
            temp+=inp[j+1][i]
        c.append(temp)
    return set(c).issubset(set(rem))
def placer(corpus):
    # main helper function
    say=len(corpus)
    result=[]
    fin=[]
    for i in xrange(0,say):
        result.append(corpus[i])
        # loop 1
        for j in xrange(0,say):
            if(corpus[j] != corpus[i]):
                result.append(corpus[j])
                if(manycheck(result,list(set(corpus)-set(result)))) :
                    # loop 2
                    if(len(corpus[0]) == 2) :
                        fin.append(result[:])
                    else :
                        fin.append(placer_rec(corpus,result))
                    # loop 2 end
                result.pop(-1)
        # loop 1 end
        result.pop(-1)
    return fin
def placer_rec(corpus,result):
    # recursive body of the main helper function
    say=len(corpus)
    say2=len(result)
    if(say2 == len(corpus[0])) :
        return result
    for k in xrange(0,say):
        if(len(set([corpus[k]]+result)) == len([corpus[k]]+result)):
            result.append(corpus[k])
            if(manycheck(result,corpus)) :
                return placer_rec(corpus,result[:])
            result.pop(-1)
def columnist(result):
    say=len(result)
    columns=[]
    j=0
    while j < say:
        v=''
        i=0
        while i < say:
            a=result[i][j]
            v+=a
            i+=1
        j+=1
        columns.append(v)
    return columns
# main function
def place_words(corpus) :
    say=len(corpus)
    for i in range (0,say) :
        a=corpus[i]
        corpus[i]=a.upper()
    if(say == 0) :
        # if the input is an empty list
        return False
    if((say == 1) and (len(corpus[0]) == 1)) :
        # if the input exists of strings with 1 characters, return the very first one
        return [corpus[0]]
    n=len(corpus[0])
    if(say < 2*n):
        # for a matrix of n, we would need at least 2*n words.
        # if we don't have enough number of strings in the corpus, return False
        return False
    if(say > 1) :
        # run the backtracking algorithm
        final=placer(corpus)
        if(final == []) :
            # if the output list is empty, return False
            return False
        else :
            if(final[0] != [] ):
                # since there are at least two possible placements for each matrix
                # return the first one
                say=len(final)
                for j in xrange(0,say) :
                    if(final[j] == None) :
                        continue
                    columns=columnist(final[j])
                    if(len(set(columns+final[j])) == len(columns)+len(final[j])) :
                        if(len(final[j]) == len(final[j][0])):
                            return final[j]
            else :
                return False
    return False
