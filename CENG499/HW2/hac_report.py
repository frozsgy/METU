import matplotlib.pyplot as plt

from hac import *

data1 = np.load('hw2_data/hac/data1.npy')
data2 = np.load('hw2_data/hac/data2.npy')
data3 = np.load('hw2_data/hac/data3.npy')
data4 = np.load('hw2_data/hac/data4.npy')


def plot(hac_data, name, criterion):
    colors = len(hac_data)
    for i in range(colors):
        cluster = hac_data[i]
        plt.scatter([x[0] for x in cluster], [x[1] for x in cluster])
    plt.savefig('report/hac-' + name + '-' + criterion + '.png', bbox_inches='tight')
    plt.clf()


data = ["data1", "data2", "data3", "data4"]
cutoff = [2, 2, 2, 4]
criterion = [single_linkage, complete_linkage, average_linkage, centroid_linkage]

for d in range(len(data)):
    name = data[d]
    print(f"HAC of {name} started")
    datum = eval(name)
    stop_length = cutoff[d]
    for c in criterion:
        print(f"Criterion: {c.__name__}")
        hac_result = hac(datum, c, stop_length)
        plot(hac_result, name, c.__name__)
