import numpy as np
from sklearn.metrics import confusion_matrix
from sklearn.svm import SVC

train_data = np.load('hw3_data/fashion_mnist_imba/train_data.npy')
train_labels = np.load('hw3_data/fashion_mnist_imba/train_labels.npy')
test_data = np.load('hw3_data/fashion_mnist_imba/test_data.npy')
test_labels = np.load('hw3_data/fashion_mnist_imba/test_labels.npy')


def normalize_and_reshape_data(data: np.array):
    data = data / 256.
    count, x, y = data.shape
    return data.reshape((count, x * y))


def svm_part_4(data: np.array, labels: np.array, data_test: np.array, labels_test: np.array, balanced: bool = False):
    data = normalize_and_reshape_data(data)
    data_test = normalize_and_reshape_data(data_test)
    if balanced is True:
        model = SVC(C=1, kernel='rbf', class_weight='balanced')
    else:
        model = SVC(C=1, kernel='rbf')
    model.fit(data, labels)
    accuracy = model.score(data_test, labels_test)
    print(f"Accuracy: {accuracy}")
    predictions = model.predict(data_test)
    cm_result = confusion_matrix(labels_test, predictions)
    print(cm_result)


def oversample(train_data_original: np.array, train_labels_original: np.array):
    binary_list = [True if x == 1 else False for x in train_labels_original]
    zero, one = binary_list.count(False), binary_list.count(True)
    minority = zero if zero < one else one
    majority = zero if zero >= one else one
    train_data_oversampled = train_data_original
    train_labels_oversampled = train_labels_original
    minority_label = 0 if minority == zero else 1
    while minority < majority:
        for j in range(train_data.shape[0]):
            if train_labels[j] == minority_label:
                train_data_oversampled = np.append(train_data_oversampled, train_data_original[j])
                train_labels_oversampled = np.append(train_labels_oversampled, train_labels_original[j])
                minority += 1
        train_data_oversampled = train_data_oversampled.reshape((train_labels_oversampled.shape[0], 40, 40))
    return train_data_oversampled, train_labels_oversampled


def undersample(train_data_original: np.array, train_labels_original: np.array):
    binary_list = [True if x == 1 else False for x in train_labels_original]
    zero, one = binary_list.count(False), binary_list.count(True)
    minority = zero if zero < one else one
    majority = zero if zero >= one else one
    train_data_undersampled = train_data_original.reshape((train_labels_original.shape[0], 40, 40))
    train_labels_undersampled = train_labels_original
    majority_label = 0 if majority == zero else 1
    while minority < majority:
        for j in range(train_data_undersampled.shape[0]):
            if train_labels_undersampled[j] == majority_label:
                train_data_undersampled = np.delete(train_data_undersampled[:][:], j, axis=0)
                train_labels_undersampled = np.delete(train_labels_undersampled, j)
                majority -= 1
                break
        train_data_undersampled = train_data_undersampled.reshape((train_labels_undersampled.shape[0], 40, 40))
    return train_data_undersampled, train_labels_undersampled


if __name__ == "__main__":
    import sys
    sys.stdout = open('plots/svm/q4.out', 'w')
    print("initial checks on the data")
    binary_list = [True if x == 1 else False for x in train_labels]
    print(f"0 count: {binary_list.count(False)}")
    print(f"1 count: {binary_list.count(True)}")
    print("-------")
    print("initial train data")
    svm_part_4(train_data, train_labels, test_data, test_labels)
    print("-------")
    print("oversampled train data")
    oversampled_train_data, oversampled_train_labels = oversample(train_data, train_labels)
    print(f"count of elements after oversampling: {oversampled_train_labels.shape[0]}")
    svm_part_4(oversampled_train_data, oversampled_train_labels, test_data, test_labels)
    print("-------")
    print("undersampled train data")
    undersampled_train_data, undersampled_train_labels = undersample(train_data, train_labels)
    print(f"count of elements after undersampling: {undersampled_train_labels.shape[0]}")
    svm_part_4(undersampled_train_data, undersampled_train_labels, test_data, test_labels)
    print("-------")
    print("balanced train data")
    svm_part_4(train_data, train_labels, test_data, test_labels, True)
    sys.stdout.close()
