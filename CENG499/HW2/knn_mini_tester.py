import numpy as np
from knn import calculate_distances, majority_voting, knn, split_train_and_validation, cross_validation

# The test data
train_data = np.asarray([
    [1.00229336, 1.64605035],
    [-0.59534321, 0.78594831],
    [0.44739161, 0.00984283],
    [3.25602912, 1.17323974],
    [1.50325745, 2.18060707],
    [0.06695968, -2.63814856],
    [1.38923452, 1.8680799],
    [0.79061914, 0.37340831],
    [0.3284521, -0.496409],
    [2.97938117, 2.99613035],
    [1.3952806, 2.05021045],
    [-0.86099088, 0.50037295],
    [-0.42372865, -1.51281749],
    [0.45187235, 0.11525361],
    [1.98578172, 1.4013832],
    [2.05869447, 1.85138621],
    [0.91697105, 2.70282673],
    [3.63179617, 0.38343314],
    [-0.86653864, -0.3959372],
    [-0.76469813, 0.49819759]
])

train_labels = np.asarray([1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0])

test_data = np.asarray([
    [-0.05612142, -2.39111867],
    [1.08820099, 0.77408663],
    [0.48300471, -1.21905172],
    [2.94107289, 3.7095194],
    [0.31069202, 0.05317268],
    [-0.7863394, -0.42561418],
    [0.8519203, 0.49429956],
    [1.80374081, 2.35345631],
    [2.47360453, 1.52437483],
    [3.44558992, 2.2965116]
])

test_labels = np.asarray([0, 1, 0, 1, 0, 0, 0, 1, 1, 1])

# Expected results
td_gt = np.asarray([
    [1.00229336, 1.64605035],
    [-0.59534321, 0.78594831],
    [0.44739161, 0.00984283],
    [3.25602912, 1.17323974],
    [1.50325745, 2.18060707],
    [1.3952806, 2.05021045],
    [-0.86099088, 0.50037295],
    [-0.42372865, -1.51281749],
    [0.45187235, 0.11525361],
    [1.98578172, 1.4013832],
    [2.05869447, 1.85138621],
    [0.91697105, 2.70282673],
    [3.63179617, 0.38343314],
    [-0.86653864, -0.3959372],
    [-0.76469813, 0.49819759]
])
tl_gt = np.asarray([1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0])
vd_gt = np.asarray([
    [0.06695968, -2.63814856],
    [1.38923452, 1.8680799],
    [0.79061914, 0.37340831],
    [0.3284521, -0.496409],
    [2.97938117, 2.99613035]
])
vl_gt = np.asarray([0, 1, 1, 0, 1])
distances_gt = np.asarray([
    4.173604622214496,
    3.2225013164026985,
    2.4531900651726994,
    4.8656954358611495,
    4.830355960173227,
    0.27599406466556853,
    4.497757913892579,
    2.8912936549401262,
    1.9333446474637417,
    6.183585365901216,
    4.672469601379987,
    3.0014227686500474,
    0.9521281627688918,
    2.5573344865916954,
    4.3072542143569095,
    4.740389636456091,
    5.186057143278684,
    4.615070302498726,
    2.1534913904410877,
    2.9749335125771825
])
major_class_gt = 0
knn_k2_acc_gt = 0.8
cv_k3_5f_acc_gt = 0.9

# Tests
distances = calculate_distances(train_data, test_data[0])
print('calculate_distances test:', np.all(np.abs(distances - distances_gt) < 10 ** -5))

major_class = majority_voting(distances, train_labels, 2)
print('majority_voting test:', major_class == major_class_gt)

knn_k2_acc = knn(train_data, train_labels, test_data, test_labels, 2)
print('knn test:', abs(knn_k2_acc - knn_k2_acc_gt) < 10 ** -5)

td, tl, vd, vl = split_train_and_validation(train_data, train_labels, 1, 4)
print('split_train_and_validation test (train_data):', np.all(np.abs(td - td_gt) < 10 ** -5))
print('split_train_and_validation test (train_labels):', np.all(np.abs(tl - tl_gt) < 10 ** -5))
print('split_train_and_validation test (validation_data):', np.all(np.abs(vd - vd_gt) < 10 ** -5))
print('split_train_and_validation test (validation_labels):', np.all(np.abs(vl - vl_gt) < 10 ** -5))

cv_k3_5f_acc = cross_validation(train_data, train_labels, 3, 5)
print('cross_validation test:', abs(cv_k3_5f_acc - cv_k3_5f_acc_gt) < 10 ** -5)
