import numpy as np
from sklearn.svm import SVC

from draw import draw_svm

train_data = np.load('hw3_data/linsep/train_data.npy')
train_labels = np.load('hw3_data/linsep/train_labels.npy')
q1_c_values = [0.01, 0.1, 1, 10, 100]


def svm_part_1(c: float, data: np.array, labels: np.array, save: bool = True):
    model = SVC(C=c, kernel='linear')
    model.fit(data, labels)
    x_values = [x[0] for x in data]
    y_values = [x[1] for x in data]
    min_x, min_y = min(x_values), min(y_values)
    max_x, max_y = max(x_values), max(y_values)
    if save is True:
        draw_svm(model, data, labels, min_x, max_x, min_y, max_y, f"plots/svm/q1-{c}.png")
    else:
        draw_svm(model, data, labels, min_x, max_x, min_y, max_y)


if __name__ == "__main__":
    for c in q1_c_values:
        svm_part_1(c, train_data, train_labels, True)
