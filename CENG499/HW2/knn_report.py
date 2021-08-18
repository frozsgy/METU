from knn import *
import numpy as np
import matplotlib.pyplot as plt

train_data = np.load('hw2_data/knn/train_data.npy')
train_labels = np.load('hw2_data/knn/train_labels.npy')
test_data = np.load('hw2_data/knn/test_data.npy')
test_labels = np.load('hw2_data/knn/test_labels.npy')

accuracies = []
for i in range(1, 200):
    if i % 10 == 0:
        print("Testing k: " + str(i))
    accuracy = cross_validation(train_data, train_labels, i, 10)
    accuracies.append(accuracy)

print(accuracies)
max_accuracy = max(accuracies)
print(f"Max accuracy: {max_accuracy}")
print(f"K-value: {accuracies.index(max_accuracy) + 1}")

k_values = range(1, 200)
plt.plot(k_values, accuracies)
plt.xlabel('k-value')
plt.ylabel('accuracy')
plt.title('KNN Accuracy with 10-fold Cross Validation')
plt.savefig('report/knn_accuracy.png', bbox_inches='tight')

