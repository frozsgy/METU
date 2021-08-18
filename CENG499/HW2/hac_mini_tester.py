import numpy as np
from hac import single_linkage, complete_linkage, average_linkage, centroid_linkage, hac

# The test data
c1 = np.asarray([
    [1.47981966, 0.3779919],
    [0.17827043, -0.06100103],
    [-0.77066388, 2.78532237],
    [-0.35268886, -1.2085455],
    [-1.06636933, -0.6026446]
])

c2 = np.asarray([
    [1.60632641, 0.88242222],
    [1.18725603, 0.87413633],
    [0.74175967, -0.55630754],
    [0.37839523, -0.58218478],
    [-0.12271933, 1.31384896],
    [-1.06544954, 2.04713934],
    [0.48385501, 2.55017274]
])

data = np.asarray([
    [0.22975855, -0.42491258],
    [0.40462076, 0.72138347],
    [0.84674953, -0.8131361],
    [0.49434961, -0.15305824],
    [-1.66927078, -1.27206789],
    [0.1906099, -2.51907944],
    [0.92242593, -2.13992198],
    [-0.2593339, -0.23849887],
    [0.48504036, 0.02428699],
    [1.49404008, -0.7387734],
    [0.24256719, 2.02626854],
    [0.71865615, 0.0355671],
    [0.74947293, 0.54188572],
    [-1.27187018, -0.21546386],
    [1.25098885, -0.64396216],
    [0.23378585, 0.08711245],
    [0.54329319, 0.24704488],
    [-0.64933706, 1.88489437],
    [1.40015199, 1.14460971],
    [-0.13984224, 0.85937304]
])
result_c1_gt = np.asarray([
    [-1.66927078, -1.27206789],
    [-1.27187018, -0.21546386],
    [0.1906099, -2.51907944],
    [0.92242593, -2.13992198]
])
result_c2_gt = np.asarray([
    [-0.64933706, 1.88489437],
    [-0.2593339, -0.23849887],
    [-0.13984224, 0.85937304],
    [0.22975855, -0.42491258],
    [0.23378585, 0.08711245],
    [0.24256719, 2.02626854],
    [0.40462076, 0.72138347],
    [0.48504036, 0.02428699],
    [0.49434961, -0.15305824],
    [0.54329319, 0.24704488],
    [0.71865615, 0.0355671],
    [0.74947293, 0.54188572],
    [0.84674953, -0.8131361],
    [1.25098885, -0.64396216],
    [1.40015199, 1.14460971],
    [1.49404008, -0.7387734]
])

# Expected results
single_linkage_dist_gt = 0.5200518296582225
complete_linkage_dist_gt = 3.8506841540359127
average_linkage_dist_gt = 2.094755341238788
centroid_linkage_dist_gt = 0.8797707689738469

# Tests
single_linkage_dist = single_linkage(c1, c2)
print('single_linkage test:', abs(single_linkage_dist - single_linkage_dist_gt) < 10 ** -5)

complete_linkage_dist = complete_linkage(c1, c2)
print('complete_linkage test:', abs(complete_linkage_dist - complete_linkage_dist_gt) < 10 ** -5)

average_linkage_dist = average_linkage(c1, c2)
print('average_linkage test:', abs(average_linkage_dist - average_linkage_dist_gt) < 10 ** -5)

centroid_linkage_dist = centroid_linkage(c1, c2)
print('centroid_linkage test:', abs(centroid_linkage_dist - centroid_linkage_dist_gt) < 10 ** -5)

clusters = hac(data, complete_linkage, 2)
result_c1 = clusters[0]
result_c1 = result_c1[np.argsort(result_c1[:, 0])]
result_c2 = clusters[1]
result_c2 = result_c2[np.argsort(result_c2[:, 0])]
if result_c1.shape[0] != result_c1_gt.shape[0]:
    result_c1, result_c2 = result_c2, result_c1
if result_c1.shape[0] != result_c1_gt.shape[0]:
    print('hac test: Shapes of the numpy array results do not match.')
else:
    print('hac test (result_c1):', np.all(np.abs(result_c1 - result_c1_gt) < 10 ** -5))
    print('hac test (result_c2):', np.all(np.abs(result_c2 - result_c2_gt) < 10 ** -5))

