

# Folder Structure

## Model

Contains all necessary Python files that was used during the training and test of the model. 

- **requirements.txt**: Pip freeze output. Required packages list for the project.
- **dataset.py**: Dataset class, adapted from the recitation videos.
- **model.py**: Contains 3 classes as models, according to the layer count. Adapted from the recitation videos.
- **scoreboard.py**: A small script to create txt file for the scoreboard. Requires a trained model.
- **train.py**: Contains a main train method, a train method that also calculates validation loss, and a main method. Initially, I forgot calculating validation loss and I created my project without using it, however later while writing the report, I noticed my mistake and created a train method that also utilizes validation loss. The main method is initialized with command line arguments for efficiency. 
- **test_all.sh**: A shell script that runs all possible training parameters and saves the outputs in the `out` folder. 


## Results

The results folder contains two files: 
- **results**: The output of `tail` for each training result. Since the training results print the accuracies at the end, I used this to gather information about different training settings and their accuracies.
- **tl_vl_best.csv**: The data of training loss / validation loss for the best training option. Since I had forgotten to report the validation loss values at the beginning, I re-run the training model with the best options, and I get quite similar results to the previous training.
  - Initial results (can be seen in the PDF and the results file):
    ``` 
    Training correctness: 72.684
    Validation correctness: 58.88
    ```
  - Second run (can be seen in the tl_vl_best.csv file):
    ``` 
    Training correctness: 73.048
    Validation correctness: 57.56
    ```

## Logs

In order not to cause excessive file sizes, I opted for not storing the logs in this archive. However full logs are available at [https://user.ceng.metu.edu.tr/~e2309615/ceng499/hw1/](https://user.ceng.metu.edu.tr/~e2309615/ceng499/hw1/). The [logs.tar.gz](https://user.ceng.metu.edu.tr/~e2309615/ceng499/hw1/logs.tar.gz) file contains all the logs as a tarball. Individual logs can be downloaded from the [logs](https://user.ceng.metu.edu.tr/~e2309615/ceng499/hw1/logs/) folder.