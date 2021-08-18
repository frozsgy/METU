import math

import numpy as np


def single_linkage(c1, c2):
    """
    Given clusters c1 and c2, calculates the single linkage criterion.
    :param c1: An (N, D) shaped numpy array containing the data points in cluster c1.
    :param c2: An (M, D) shaped numpy array containing the data points in cluster c2.
    :return: A float. The result of the calculation.
    """
    linkage = None
    for i in c1:
        for j in c2:
            x_1, y_1 = i
            x_2, y_2 = j
            calculated = (x_1 - x_2) ** 2 + (y_1 - y_2) ** 2
            if linkage is None:
                linkage = calculated
            if calculated < linkage:
                linkage = calculated
    return math.sqrt(linkage)


def complete_linkage(c1, c2):
    """
    Given clusters c1 and c2, calculates the complete linkage criterion.
    :param c1: An (N, D) shaped numpy array containing the data points in cluster c1.
    :param c2: An (M, D) shaped numpy array containing the data points in cluster c2.
    :return: A float. The result of the calculation.
    """
    linkage = None
    for i in c1:
        for j in c2:
            x_1, y_1 = i
            x_2, y_2 = j
            calculated = (x_1 - x_2) ** 2 + (y_1 - y_2) ** 2
            if linkage is None:
                linkage = calculated
            if calculated > linkage:
                linkage = calculated
    return math.sqrt(linkage)


def average_linkage(c1, c2):
    """
    Given clusters c1 and c2, calculates the average linkage criterion.
    :param c1: An (N, D) shaped numpy array containing the data points in cluster c1.
    :param c2: An (M, D) shaped numpy array containing the data points in cluster c2.
    :return: A float. The result of the calculation.
    """
    linkage = 0
    for i in c1:
        for j in c2:
            x_1, y_1 = i
            x_2, y_2 = j
            calculated = (x_1 - x_2) ** 2 + (y_1 - y_2) ** 2
            linkage += math.sqrt(calculated)
    cross = len(c1) * len(c2)
    return linkage / cross


def centroid_linkage(c1, c2):
    """
    Given clusters c1 and c2, calculates the centroid linkage criterion.
    :param c1: An (N, D) shaped numpy array containing the data points in cluster c1.
    :param c2: An (M, D) shaped numpy array containing the data points in cluster c2.
    :return: A float. The result of the calculation.
    """
    d_1 = len(c1)
    d_2 = len(c2)
    x_1 = sum([x[0] for x in c1])
    y_1 = sum([x[1] for x in c1])
    x_2 = sum([x[0] for x in c2])
    y_2 = sum([x[1] for x in c2])
    centroid_1 = x_1 / d_1, y_1 / d_1
    centroid_2 = x_2 / d_2, y_2 / d_2
    sq_euclidean = (centroid_1[0] - centroid_2[0]) ** 2 + (centroid_1[1] - centroid_2[1]) ** 2
    return math.sqrt(sq_euclidean)


def hac(data, criterion, stop_length):
    """
    Applies hierarchical agglomerative clustering algorithm with the given criterion on the data
    until the number of clusters reaches the stop_length.
    :param data: An (N, D) shaped numpy array containing all of the data points.
    :param criterion: A function. It can be single_linkage, complete_linkage, average_linkage, or
    centroid_linkage
    :param stop_length: An integer. The length at which the algorithm stops.
    :return: A list of numpy arrays with length stop_length. Each item in the list is a cluster
    and a (Ni, D) sized numpy array.
    """
    cluster = [[x] for x in data.tolist()]
    cluster_count = len(cluster)
    while stop_length < cluster_count:
        min_distance = None
        p, q = None, None
        for i in range(cluster_count):
            for j in range(i + 1, cluster_count):
                linkage = criterion(cluster[i], cluster[j])
                if min_distance is None:
                    min_distance = linkage
                    p, q = i, j
                if linkage < min_distance:
                    min_distance = linkage
                    p, q = i, j
        old_cluster_1, old_cluster_2 = cluster[p], cluster[q]
        new_cluster = old_cluster_1 + old_cluster_2
        cluster.remove(old_cluster_1)
        cluster.remove(old_cluster_2)
        cluster.append(new_cluster)
        cluster_count = len(cluster)
    return [np.asarray(x) for x in cluster]
