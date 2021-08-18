import matplotlib.pyplot as plt

from kmeans import *

clustering1 = np.load('hw2_data/kmeans/clustering1.npy')
clustering2 = np.load('hw2_data/kmeans/clustering2.npy')
clustering3 = np.load('hw2_data/kmeans/clustering3.npy')
clustering4 = np.load('hw2_data/kmeans/clustering4.npy')


def restart_kmeans(data, k, times=10):
    minimum_objective = 0
    first = True
    for i in range(times):
        clusters = initialize_cluster_centers(data, k)
        cluster_centers, objective = kmeans(data, clusters)
        if first is True:
            minimum_objective = objective
        else:
            if minimum_objective > objective:
                minimum_objective = objective
    print(f"Best objective of k value: {k} for {times} times: {minimum_objective}")
    return minimum_objective


def plot(elbow_graph, name):
    plt.plot([x[0] for x in elbow_graph], [x[1] for x in elbow_graph])
    plt.grid()
    plt.xticks(np.arange(0, 11, 1))
    max_tick = int(round(sorted([x[1] for x in elbow_graph], reverse=True)[0], -3))
    step_size = 1000 if max_tick > 10000 else 500
    plt.yticks(np.arange(0, max_tick, step_size))
    plt.xlabel('k')
    plt.ylabel('Best Objective')
    plt.savefig('report/elbow-' + name + '.png', bbox_inches='tight')
    plt.clf()


def elbow(name, data, k_max=11, times=10):
    print(f"Starting Elbow plot for {name}")
    elbow_graph = dict()
    for k in range(1, k_max):
        average_objective = restart_kmeans(data, k, times)
        elbow_graph[k] = average_objective
    elbow_graph = sorted(elbow_graph.items())
    print("Objectives: ")
    print([x[1] for x in elbow_graph])
    plot(elbow_graph, name)


def plot_elbows():
    elbow("clustering1", clustering1)
    elbow("clustering2", clustering2)
    elbow("clustering3", clustering3)
    elbow("clustering4", clustering4)


def plot_best():
    best = {
        "clustering1": 2,
        "clustering2": 3,
        "clustering3": 4,
        "clustering4": 5,
    }
    for key, value in best.items():
        data = eval(key)
        clusters = initialize_cluster_centers(data, value)
        cluster_centers, objective = kmeans(data, clusters)
        labels = assign_clusters(data, cluster_centers)
        plt.scatter([x[0] for x in data], [x[1] for x in data], c=labels)
        plt.scatter([x[0] for x in cluster_centers], [x[1] for x in cluster_centers], c='r', marker='P')
        plt.savefig('report/kmeans-' + key + '-' + str(value) + '.png', bbox_inches='tight')
        plt.clf()


plot_best()
