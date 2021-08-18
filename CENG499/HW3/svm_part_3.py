import numpy as np
from sklearn.model_selection import GridSearchCV
from sklearn.svm import SVC

train_data = np.load('hw3_data/fashion_mnist/train_data.npy')
train_labels = np.load('hw3_data/fashion_mnist/train_labels.npy')
test_data = np.load('hw3_data/fashion_mnist/test_data.npy')
test_labels = np.load('hw3_data/fashion_mnist/test_labels.npy')
kernels = ["linear", "rbf", "poly", "sigmoid"]
c_values = [0.01, 0.1, 1, 10, 100]
gamma_values = [0.00001, 0.0001, 0.001, 0.01, 0.1, 1]


def normalize_and_reshape_data(data: np.array):
    data = data / 256.
    count, x, y = data.shape
    return data.reshape((count, x * y))


def svm_part_3(data: np.array, labels: np.array):
    data_reshaped = normalize_and_reshape_data(data)
    parameters = {'kernel': kernels, 'C': c_values, 'gamma': gamma_values}
    svc = SVC()
    print("-------")
    print("Start grid search")
    clf = GridSearchCV(svc, parameters, cv=5, verbose=5, return_train_score=True)
    clf.fit(data_reshaped, labels)
    print("-------")
    print("Cross validation results:")
    for key, value in clf.cv_results_.items():
        print(f"{key}: {value}")
    print("-------")
    print("Best params: ")
    print(clf.best_params_)
    print("Best estimator: ")
    print(clf.best_estimator_)


def cv():
    import sys
    sys.stdout = open('plots/svm/q3.out', 'w')
    svm_part_3(train_data, train_labels)
    sys.stdout.close()


def train_with_best(data: np.array, labels: np.array, data_test: np.array, labels_test: np.array):
    # {'C': 100, 'gamma': 0.01, 'kernel': 'rbf'}
    data = normalize_and_reshape_data(data)
    data_test = normalize_and_reshape_data(data_test)
    model = SVC(C=100, kernel='rbf', gamma=0.01)
    model.fit(data, labels)
    accuracy = model.score(data_test, labels_test)
    print(f"Accuracy: {accuracy}")


if __name__ == "__main__":
    # cv()
    train_with_best(train_data, train_labels, test_data, test_labels)
