import numpy as np
from dt import entropy, info_gain, gini, avg_gini_index, calculate_split_values, chi_squared_test

parent_bucket = [3, 2, 3]
left_bucket = [3, 0, 2]
right_bucket = [0, 2, 1]

print('entropy:', abs(entropy(parent_bucket) - 1.5612781244591325) < 10 ** -5)

print('info_gain:', abs(info_gain(parent_bucket, left_bucket, right_bucket) - 0.610073065154531) < 10 ** -5)

print('gini:', abs(gini(parent_bucket) - 0.65625) < 10 ** -5)

print('avg_gini_index:', abs(avg_gini_index(left_bucket, right_bucket) - 0.4666666666666667) < 10 ** -5)

data = np.asarray([
    [0.96712763, 0.27892349, 0.69429896, 0.04024055],
    [0.0576444, 0.33726678, 0.57879485, 0.81960005],
    [0.70768221, 0.30983012, 0.80722421, 0.13924751],
    [0.42084337, 0.7296714, 0.00308904, 0.24135345],
    [0.65534721, 0.44364458, 0.63468942, 0.27418721],
    [0.98472834, 0.6466202, 0.18471949, 0.9535479],
    [0.63624549, 0.30568322, 0.41870169, 0.85743963],
    [0.17610217, 0.20381821, 0.68492418, 0.57177705],
    [0.21855323, 0.97823166, 0.38690695, 0.79345037],
    [0.53118909, 0.74468352, 0.88166667, 0.50417511]
])

values_info_gain_gt = np.asarray([
    [0.24137085, 0.07898214],
    [0.29230335, 0.17095059],
    [0.30775667, 0.2812909],
    [0.32354845, 0.41997309],
    [0.39045568, 0.12451125],
    [0.54513239, 0.25642589],
    [0.6881458, 0.09127745],
    [0.73717746, 0.00740339],
    [0.86145759, 0.07898214]
])

values_avg_gini_index_gt = np.asarray([
    [0.24137085, 0.44444444],
    [0.29230335, 0.4],
    [0.30775667, 0.34285714],
    [0.32354845, 0.26666667],
    [0.39045568, 0.4],
    [0.54513239, 0.31666667],
    [0.6881458, 0.41904762],
    [0.73717746, 0.475],
    [0.86145759, 0.44444444]
])

labels = np.asarray([0, 1, 0, 1, 0, 1, 0, 0, 0, 1])

values_info_gain = calculate_split_values(data, labels, 2, 1, 'info_gain')
values_avg_gini_index = calculate_split_values(data, labels, 2, 1, 'avg_gini_index')

print('calculate_split_values (info_gain): ', np.all(np.abs(values_info_gain - values_info_gain_gt) < 10 ** -5))
print('calculate_split_values (avg_gini_index): ',
      np.all(np.abs(values_avg_gini_index - values_avg_gini_index_gt) < 10 ** -5))

chi_squared, df = chi_squared_test(left_bucket, right_bucket)
print('chi_squared:', abs(chi_squared - 5.155555555555557) < 10 ** -5)
print('degree_of_freedom:', df == 2)

left_bucket2 = [0, 3, 2]
right_bucket2 = [0, 1, 4]
chi_squared2, df2 = chi_squared_test(left_bucket2, right_bucket2)
print('chi_squared:', abs(chi_squared2 - 1.6666666666666665) < 10 ** -5)
print('degree_of_freedom:', df2 == 1)
