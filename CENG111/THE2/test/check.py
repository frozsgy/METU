import the2

def compare((x1,y1),(x2,y2)):
	if abs(x1-x2)<0.001 and abs(y1-y2)<0.001 :
		return 1
	else:
		return 0


def check(list1,list2):

	list1 = sorted(list1)
	list2 = sorted(list2)

	count = 0

	if len(list1)==len(list2):
		count = 0
		for i in range(len(list1)):
			count += compare(list1[i],list2[i])


	if count == len(list1):
		print 'SUCCESS'
	else:
		print 'FAIL'

shapes = input()
ground_truth = input()

shape1,shape2=shapes

result = the2.minority_shape_intersect(shape1,shape2)

check(result,ground_truth)
