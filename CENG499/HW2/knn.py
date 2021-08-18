import math

import numpy as np


def calculate_distances(train_data, test_datum):
    """
    Calculates euclidean distances between test_datum and every train_data
    :param train_data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param test_datum: A (D, ) shaped numpy array
    :return: An (N, ) shaped numpy array that contains distances
    """
    N, D = train_data.shape
    distances = []
    for t in train_data:
        s = 0.0
        for d in range(D):
            s += (test_datum[d] - t[d]) ** 2
        distances.append(math.sqrt(s))
    return np.asarray(distances)


def majority_voting(distances, labels, k):
    """
    Applies majority voting. If there are more then one major class, returns the smallest label.
    :param distances: An (N, ) shaped numpy array that contains distances
    :param labels: An (N, ) shaped numpy array that contains labels
    :param k: An integer. The number of nearest neighbor to be selected.
    :return: An integer. The label of the majority class.
    """
    distance_count = distances.shape[0]
    labels_dict = dict()
    for i in set(labels):
        labels_dict[i] = 0
    distance_array = []
    for i in range(distance_count):
        distance_array.append((labels[i], distances[i]))
    distance_array.sort(key=lambda x: x[1])
    selected = distance_array[:k]
    selected_labels = [x[0] for x in selected]
    for l in selected_labels:
        labels_dict[l] += 1
    labels_nested = [(key, value) for key, value in labels_dict.items()]
    labels_nested.sort(key=lambda x: x[0])
    labels_nested.sort(key=lambda x: x[1], reverse=True)
    return labels_nested[0][0]


def knn(train_data, train_labels, test_data, test_labels, k):
    """
    Calculates accuracy of knn on test data using train_data.
    :param train_data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param train_labels: An (N, ) shaped numpy array that contains labels
    :param test_data: An (M, D) shaped numpy array where M is the number of examples
    and D is the dimension of the data
    :param test_labels: An (M, ) shaped numpy array that contains labels
    :param k: An integer. The number of nearest neighbor to be selected.
    :return: A float. The calculated accuracy.
    """
    predictions = []
    for test_datum in test_data:
        distances = calculate_distances(train_data, test_datum)
        prediction = majority_voting(distances, train_labels, k)
        predictions.append(prediction)
    correct = 0
    total = len(test_labels)
    for i in range(total):
        if test_labels[i] == predictions[i]:
            correct += 1
    return float(correct) / total


def split_train_and_validation(whole_train_data, whole_train_labels, validation_index, k_fold):
    """
    Splits training dataset into k and returns the validation_indexth one as the
    validation set and others as the training set. You can assume k_fold divides N.
    :param whole_train_data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param whole_train_labels: An (N, ) shaped numpy array that contains labels
    :param validation_index: An integer. 0 <= validation_index < k_fold. Specifies which fold
    will be assigned as validation set.
    :param k_fold: The number of groups that the whole_train_data will be divided into.
    :return: train_data, train_labels, validation_data, validation_labels
    train_data.shape is (N-N/k_fold, D).
    train_labels.shape is (N-N/k_fold, ).
    validation_data.shape is (N/k_fold, D).
    validation_labels.shape is (N/k_fold, ).
    """
    data_size = whole_train_data.shape[0]
    step_size = int(data_size / k_fold)
    train_begin = 0
    train_mid_end = validation_index * step_size
    train_mid_start = (validation_index + 1) * step_size
    train_end = data_size
    train_data_pt1 = whole_train_data[train_begin:train_mid_end]
    validation_data = whole_train_data[train_mid_end:train_mid_start]
    train_data_pt2 = whole_train_data[train_mid_start:train_end]
    train_labels_pt1 = whole_train_labels[train_begin:train_mid_end]
    validation_labels = whole_train_labels[train_mid_end:train_mid_start]
    train_labels_pt2 = whole_train_labels[train_mid_start:train_end]
    return np.concatenate((train_data_pt1, train_data_pt2)), np.concatenate((train_labels_pt1, train_labels_pt2)), validation_data, validation_labels


def cross_validation(whole_train_data, whole_train_labels, k, k_fold):
    """
    Applies k_fold cross-validation and averages the calculated accuracies.
    :param whole_train_data: An (N, D) shaped numpy array where N is the number of examples
    and D is the dimension of the data
    :param whole_train_labels: An (N, ) shaped numpy array that contains labels
    :param k: An integer. The number of nearest neighbor to be selected.
    :param k_fold: An integer.
    :return: A float. Average accuracy calculated.
    """
    accuracies = []
    for v in range(k_fold):
        train_data, train_labels, validation_data, validation_labels = split_train_and_validation(whole_train_data, whole_train_labels, v, k_fold)
        accuracies.append(knn(train_data, train_labels, validation_data, validation_labels, k))
    return sum(accuracies) / len(accuracies)
