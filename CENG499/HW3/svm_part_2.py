import numpy as np
from sklearn.svm import SVC

from draw import draw_svm

train_data = np.load('hw3_data/nonlinsep/train_data.npy')
train_labels = np.load('hw3_data/nonlinsep/train_labels.npy')
kernels = ["linear", "rbf", "poly", "sigmoid"]


def svm_part_2(kernel: str, data: np.array, labels: np.array, save: bool = True):
    model = SVC(C=1, kernel=kernel)
    model.fit(data, labels)
    x_values = [x[0] for x in data]
    y_values = [x[1] for x in data]
    min_x, min_y = min(x_values), min(y_values)
    max_x, max_y = max(x_values), max(y_values)
    if save is True:
        draw_svm(model, data, labels, min_x, max_x, min_y, max_y, f"plots/svm/q2-{kernel}.png")
    else:
        draw_svm(model, data, labels, min_x, max_x, min_y, max_y)


if __name__ == "__main__":
    for k in kernels:
        svm_part_2(k, train_data, train_labels, True)
