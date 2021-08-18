import math
from functools import reduce

import numpy as np


def entropy(bucket):
    """
    Calculates the entropy.
    :param bucket: A list of size num_classes. bucket[i] is the number of
    examples that belong to class i.
    :return: A float. Calculated entropy.
    """
    num_classes = len(bucket)
    total_count = sum(bucket)
    if total_count == 0:
        return 0
    calculated_entropy = 0
    for i in range(num_classes):
        p = bucket[i] / total_count
        if p != 0:
            e = -math.log2(p) * p
        else:
            e = 0
        calculated_entropy += e
    return calculated_entropy


def info_gain(parent_bucket, left_bucket, right_bucket):
    """
    Calculates the information gain. A bucket is a list of size num_classes.
    bucket[i] is the number of examples that belong to class i.
    :param parent_bucket: Bucket belonging to the parent node. It contains the
    number of examples that belong to each class before the split.
    :param left_bucket: Bucket belonging to the left child after the split.
    :param right_bucket: Bucket belonging to the right child after the split.
    :return: A float. Calculated information gain.
    """
    total_count = sum(parent_bucket)
    parent_entropy = entropy(parent_bucket)
    left_entropy = entropy(left_bucket)
    right_entropy = entropy(right_bucket)
    left_ratio = sum(left_bucket) / total_count
    right_ratio = sum(right_bucket) / total_count
    return parent_entropy - left_ratio * left_entropy - right_ratio * right_entropy


def gini(bucket):
    """
    Calculates the gini index.
    :param bucket: A list of size num_classes. bucket[i] is the number of
    examples that belong to class i.
    :return: A float. Calculated gini index.
    """
    total_count = sum(bucket)
    gini = 1
    for i in bucket:
        gini -= (i / total_count) ** 2
    return gini


def avg_gini_index(left_bucket, right_bucket):
    """
    Calculates the average gini index. A bucket is a list of size num_classes.
    bucket[i] is the number of examples that belong to class i.
    :param left_bucket: Bucket belonging to the left child after the split.
    :param right_bucket: Bucket belonging to the right child after the split.
    :return: A float. Calculated average gini index.
    """
    left_gini = gini(left_bucket)
    right_gini = gini(right_bucket)
    left_count = sum(left_bucket)
    right_count = sum(right_bucket)
    left_ratio = left_count / (left_count + right_count)
    right_ratio = right_count / (left_count + right_count)
    return left_gini * left_ratio + right_gini * right_ratio


def calculate_split_values(data, labels, num_classes, attr_index, heuristic_name):
    """
    For every possible values to split the data for the attribute indexed by
    attribute_index, it divides the data into buckets and calculates the values
    returned by the heuristic function named heuristic_name. The split values
    should be the average of the closest 2 values. For example, if the data has
    2.1 and 2.2 in it consecutively for the values of attribute index by attr_index,
    then one of the split values should be 2.15.
    :param data: An (N, M) shaped numpy array. N is the number of examples in the
    current node. M is the dimensionality of the data. It contains the values for
    every attribute for every example.
    :param labels: An (N, ) shaped numpy array. It contains the class values in
    it. For every value, 0 <= value < num_classes.
    :param num_classes: An integer. The number of classes in the dataset.
    :param attr_index: An integer. The index of the attribute that is going to
    be used for the splitting operation. This integer indexs the second dimension
    of the data numpy array.
    :param heuristic_name: The name of the heuristic function. It should either be
    'info_gain' of 'avg_gini_index' for this homework.
    :return: An (L, 2) shaped numpy array. L is the number of split values. The
    first column is the split values and the second column contains the calculated
    heuristic values for their splits.
    """
    attributes = [x[attr_index] for i, x in enumerate(data)]
    attributes_sorted = sorted(attributes)
    splits = []
    for i in range(len(attributes_sorted) - 1):
        splits.append((attributes_sorted[i] + attributes_sorted[i + 1]) / 2)
    heuristics = []
    for split_value in splits:
        left_bucket = filter(lambda x: x is not None, [i if x[attr_index] < split_value else None for i, x in enumerate(data)])
        right_bucket = filter(lambda x: x is not None, [i if x[attr_index] >= split_value else None for i, x in enumerate(data)])
        left_labels = [0] * num_classes
        right_labels = [0] * num_classes
        all_labels = [0] * num_classes
        for l in left_bucket:
            left_labels[labels[l]] += 1
        for l in right_bucket:
            right_labels[labels[l]] += 1
        for i in range(num_classes):
            all_labels[i] = left_labels[i] + right_labels[i]
        if heuristic_name == "info_gain":
            heuristic = info_gain(all_labels, left_labels, right_labels)
        else:
            heuristic = avg_gini_index(left_labels, right_labels)
        heuristics.append(heuristic)
    return np.asarray(list(zip(splits, heuristics)))


def chi_squared_test(left_bucket, right_bucket):
    """
    Calculates chi squared value and degree of freedom between the selected attribute
    and the class attribute. A bucket is a list of size num_classes. bucket[i] is the
    number of examples that belong to class i.
    :param left_bucket: Bucket belonging to the left child after the split.
    :param right_bucket: Bucket belonging to the right child after the split.
    :return: A float and and integer. Chi squared value and degree of freedom.
    """
    num_classes = len(left_bucket)
    table = [left_bucket[:] + [sum(left_bucket)], right_bucket[:] + [sum(right_bucket)], [0] * (num_classes + 1)]
    for i in range(2):
        for j in range(num_classes + 1):
            table[2][j] += table[i][j]
    expected_table = [left_bucket[:], right_bucket[:]]
    total_count = sum(left_bucket) + sum(right_bucket)

    for i in range(2):
        for j in range(num_classes):
            expected_table[i][j] = (table[2][j] * table[i][num_classes]) / total_count

    chi_square = 0
    for i in range(2):
        for j in range(num_classes):
            if expected_table[i][j] != 0:
                chi_square += ((table[i][j] - expected_table[i][j]) ** 2) / expected_table[i][j]

    rows = reduce(lambda x, y: x + 1, filter(lambda x: x != 0, [sum(left_bucket[:]), sum(right_bucket[:])]), 0)
    columns = reduce(lambda x, y: x + 1, filter(lambda x: x != 0, map(sum, zip(left_bucket, right_bucket))), 0)
    degree_of_freedom = (rows - 1) * (columns - 1)
    return chi_square, degree_of_freedom

