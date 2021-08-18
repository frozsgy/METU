import math

import numpy as np


def initialize_cluster_centers(data, k):
    """
    :param data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param k: Number of clusters
    :return: A (K, D) shaped numpy array where K is the number of clusters
    and D is the dimension of the data
    """
    x_min = data[0][0]
    x_max = data[0][0]
    y_min = data[0][1]
    y_max = data[0][1]
    for i in range(data.shape[0]):
        x, y = data[i]
        if x > x_max:
            x_max = x
        if x < x_min:
            x_min = x
        if y > y_max:
            y_max = y
        if y < y_min:
            y_min = y
    cluster_centers = []
    for _ in range(k):
        x = np.random.uniform(x_min, x_max)
        y = np.random.uniform(y_min, y_max)
        cluster_centers.append((x, y))
    return np.asarray(cluster_centers)


def assign_clusters(data, cluster_centers):
    """
    Assigns every data point to its closest (in terms of euclidean distance) cluster center.
    :param data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param cluster_centers: A (K, D) shaped numpy array where K is the number of clusters
    and D is the dimension of the data
    :return: An (N, ) shaped numpy array. At its index i, the index of the closest center
    resides to the ith data point.
    """
    data_size = data.shape[0]
    cluster_size = cluster_centers.shape[0]
    labels = []
    for i in range(data_size):
        min_distance = None
        label = None
        for j in range(cluster_size):
            distance = data[i] - cluster_centers[j]
            euclidean_distance = distance[0] ** 2 + distance[1] ** 2
            if min_distance is None:
                min_distance = euclidean_distance
                label = j
            if min_distance > euclidean_distance:
                min_distance = euclidean_distance
                label = j
        labels.append(label)
    return np.asarray(labels)


def calculate_cluster_centers(data, assignments, cluster_centers, k):
    """
    Calculates cluster_centers such that their squared euclidean distance to the data assigned to
    them will be lowest.
    If none of the data points belongs to some cluster center, then assign it to its previous value.
    :param data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param assignments: An (N, ) shaped numpy array with integers inside. They represent the cluster index
    every data assigned to.
    :param cluster_centers: A (K, D) shaped numpy array where K is the number of clusters
    and D is the dimension of the data
    :param k: Number of clusters
    :return: A (K, D) shaped numpy array that contains the newly calculated cluster centers.
    """
    data_size = data.shape[0]
    clusters = dict()
    for i in range(data_size):
        label = assignments[i]
        members = clusters.get(label, [])
        members.append(data[i].tolist())
        clusters[label] = members
    for label in range(k):
        if label not in clusters.keys():
            clusters[label] = []
    new_clusters = dict()
    for key, value in clusters.items():
        if len(value) == 0:
            new_clusters[key] = cluster_centers[key].tolist()
        else:
            x_center = sum([x[0] for x in value]) / len(value)
            y_center = sum([x[1] for x in value]) / len(value)
            new_clusters[key] = [x_center, y_center]
    new_clusters_list = []
    for key, value in sorted(new_clusters.items()):
        new_clusters_list.append(value)
    return np.asarray(new_clusters_list)


def kmeans(data, initial_cluster_centers):
    """
    Applies k-means algorithm.
    :param data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param initial_cluster_centers: A (K, D) shaped numpy array where K is the number of clusters
    and D is the dimension of the data
    :return: cluster_centers, objective_function
    cluster_center.shape is (K, D).
    objective function is a float. It is calculated by summing the squared euclidean distance between
    data points and their cluster centers.
    """
    labels = assign_clusters(data, initial_cluster_centers)
    k = initial_cluster_centers.shape[0]
    objective = 0
    while True:
        cluster_centers = calculate_cluster_centers(data, labels, initial_cluster_centers, k)
        same_clusters = 0
        total_clusters = len(cluster_centers)
        for i in range(total_clusters):
            if (cluster_centers[i] == initial_cluster_centers[i]).all():
                same_clusters += 1
        if same_clusters == total_clusters:
            break
        initial_cluster_centers = cluster_centers
        labels = assign_clusters(data, initial_cluster_centers)
        objective = 0
        for i in range(len(labels)):
            label = labels[i]
            cluster_x, cluster_y = initial_cluster_centers[label]
            data_x, data_y = data[i]
            objective += (data_x - cluster_x) ** 2 + (data_y - cluster_y) ** 2
    return cluster_centers, objective
