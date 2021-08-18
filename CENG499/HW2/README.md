# CENG499 HW2

## Installation

1. Create a Python virtual environment 
2. Install required pip packages

### Required Pip Packages

* Numpy
* Matplotlib

## K-Nearest Neighbours

K-Nearest Neighbours algorithm was implemented in `knn.py` file. To plot the relation between the `k-value` and `accuracy`, `knn_report.py` file was created. This file saves the accuracy/k-value plot as a png file under the report folder.

## K-Means Clustering

K-Means Clustering algorithm was implemented in `kmeans.py` file. To determine the `k` values and plot elbow plots, and clustered data `kmeans_report.py` file was created. The `plot_elbows` function creates elbow plots for each dataset, and saves them as png files under the report folder. The `plot_best` function uses the values determined by the elbow plows manually to cluster the data and plot the output accordingly. Similarly, the plots are saved under the report folder as png files.

## Hierarchical Agglomerative Clustering

Hierarchical Agglomerative Clustering algorithm was implemented in `hac.py` file. To plot the graphs, `hac_report.py` file was created. The `plot` function plots graphs according to the clustered data, and saves them as png files under the report folder.

## Extra Files

* **knn_result**: STDOUT of `knn_report.py`
* **kmeans_result**: STDOUT of `kmeans_report.py` with `plot_elbows` function