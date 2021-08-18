#!/bin/bash
echo "0 intermediate layer - epoch 100"
venv/bin/python train.py -c -e 100 -lr 0.01 > out/l0_0.01.csv
venv/bin/python train.py -c -e 100 -lr 0.003 > out/l0_0.003.csv
venv/bin/python train.py -c -e 100 -lr 0.001 > out/l0_0.001.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 > out/l0_0.0003.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 > out/l0_0.0001.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 > out/l0_0.00003.csv
echo "1 intermediate layer - epoch 100"
echo "relu"
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function relu --layer-one 512 > out/l1_0.01_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function relu --layer-one 512 > out/l1_0.003_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function relu --layer-one 512 > out/l1_0.001_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function relu --layer-one 512 > out/l1_0.0003_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function relu --layer-one 512 > out/l1_0.0001_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function relu --layer-one 512 > out/l1_0.00003_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function relu --layer-one 1024 > out/l1_0.01_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function relu --layer-one 1024 > out/l1_0.003_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function relu --layer-one 1024 > out/l1_0.001_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function relu --layer-one 1024 > out/l1_0.0003_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function relu --layer-one 1024 > out/l1_0.0001_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function relu --layer-one 1024 > out/l1_0.00003_1024_relu.csv
echo "tanh"
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function tanh --layer-one 256 > out/l1_0.01_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function tanh --layer-one 256 > out/l1_0.003_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function tanh --layer-one 256 > out/l1_0.001_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function tanh --layer-one 256 > out/l1_0.0003_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function tanh --layer-one 256 > out/l1_0.0001_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function tanh --layer-one 256 > out/l1_0.00003_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function tanh --layer-one 512 > out/l1_0.01_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function tanh --layer-one 512 > out/l1_0.003_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function tanh --layer-one 512 > out/l1_0.001_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function tanh --layer-one 512 > out/l1_0.0003_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function tanh --layer-one 512 > out/l1_0.0001_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function tanh --layer-one 512 > out/l1_0.00003_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function tanh --layer-one 1024 > out/l1_0.01_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function tanh --layer-one 1024 > out/l1_0.003_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function tanh --layer-one 1024 > out/l1_0.001_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function tanh --layer-one 1024 > out/l1_0.0003_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function tanh --layer-one 1024 > out/l1_0.0001_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function tanh --layer-one 1024 > out/l1_0.00003_1024_tanh.csv
echo "sigmoid"
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function sigmoid --layer-one 256 > out/l1_0.01_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function sigmoid --layer-one 256 > out/l1_0.003_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function sigmoid --layer-one 256 > out/l1_0.001_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function sigmoid --layer-one 256 > out/l1_0.0003_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function sigmoid --layer-one 256 > out/l1_0.0001_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function sigmoid --layer-one 256 > out/l1_0.00003_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function sigmoid --layer-one 512 > out/l1_0.01_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function sigmoid --layer-one 512 > out/l1_0.003_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function sigmoid --layer-one 512 > out/l1_0.001_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function sigmoid --layer-one 512 > out/l1_0.0003_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function sigmoid --layer-one 512 > out/l1_0.0001_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function sigmoid --layer-one 512 > out/l1_0.00003_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 1 --layer-one-function sigmoid --layer-one 1024 > out/l1_0.01_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 1 --layer-one-function sigmoid --layer-one 1024 > out/l1_0.003_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 1 --layer-one-function sigmoid --layer-one 1024 > out/l1_0.001_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 1 --layer-one-function sigmoid --layer-one 1024 > out/l1_0.0003_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 1 --layer-one-function sigmoid --layer-one 1024 > out/l1_0.0001_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 1 --layer-one-function sigmoid --layer-one 1024 > out/l1_0.00003_1024_sigmoid.csv
echo "2 intermediate layers - epoch 100"
echo "relu"
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 256 --layer-two 256 > out/l2_0.01_256_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 256 --layer-two 256 > out/l2_0.003_256_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 256 --layer-two 256 > out/l2_0.001_256_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 256 --layer-two 256 > out/l2_0.0003_256_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 256 --layer-two 256 > out/l2_0.0001_256_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 256 --layer-two 256 > out/l2_0.00003_256_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 512 --layer-two 512 > out/l2_0.01_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 512 --layer-two 512 > out/l2_0.003_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 512 --layer-two 512 > out/l2_0.001_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 512 --layer-two 512 > out/l2_0.0003_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 512 --layer-two 512 > out/l2_0.0001_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 512 --layer-two 512 > out/l2_0.00003_512_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 1024 --layer-two 1024 > out/l2_0.01_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 1024 --layer-two 1024 > out/l2_0.003_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 1024 --layer-two 1024 > out/l2_0.001_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 1024 --layer-two 1024 > out/l2_0.0003_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 1024 --layer-two 1024 > out/l2_0.0001_1024_relu.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function relu --layer-two-function relu --layer-one 1024 --layer-two 1024 > out/l2_0.00003_1024_relu.csv
echo "tanh"
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 256 --layer-two 256 > out/l2_0.01_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 256 --layer-two 256 > out/l2_0.003_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 256 --layer-two 256 > out/l2_0.001_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 256 --layer-two 256 > out/l2_0.0003_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 256 --layer-two 256 > out/l2_0.0001_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 256 --layer-two 256 > out/l2_0.00003_256_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 512 --layer-two 512 > out/l2_0.01_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 512 --layer-two 512 > out/l2_0.003_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 512 --layer-two 512 > out/l2_0.001_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 512 --layer-two 512 > out/l2_0.0003_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 512 --layer-two 512 > out/l2_0.0001_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 512 --layer-two 512 > out/l2_0.00003_512_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 1024 --layer-two 1024 > out/l2_0.01_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 1024 --layer-two 1024 > out/l2_0.003_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 1024 --layer-two 1024 > out/l2_0.001_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 1024 --layer-two 1024 > out/l2_0.0003_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 1024 --layer-two 1024 > out/l2_0.0001_1024_tanh.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function tanh --layer-two-function tanh --layer-one 1024 --layer-two 1024 > out/l2_0.00003_1024_tanh.csv
echo "sigmoid"
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 256 --layer-two 256 > out/l2_0.01_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 256 --layer-two 256 > out/l2_0.003_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 256 --layer-two 256 > out/l2_0.001_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 256 --layer-two 256 > out/l2_0.0003_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 256 --layer-two 256 > out/l2_0.0001_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 256 --layer-two 256 > out/l2_0.00003_256_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 512 --layer-two 512 > out/l2_0.01_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 512 --layer-two 512 > out/l2_0.003_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 512 --layer-two 512 > out/l2_0.001_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 512 --layer-two 512 > out/l2_0.0003_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 512 --layer-two 512 > out/l2_0.0001_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 512 --layer-two 512 > out/l2_0.00003_512_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.01 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 1024 --layer-two 1024 > out/l2_0.01_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 1024 --layer-two 1024 > out/l2_0.003_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.001 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 1024 --layer-two 1024 > out/l2_0.001_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 1024 --layer-two 1024 > out/l2_0.0003_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.0001 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 1024 --layer-two 1024 > out/l2_0.0001_1024_sigmoid.csv
venv/bin/python train.py -c -e 100 -lr 0.00003 -l 2 --layer-one-function sigmoid --layer-two-function sigmoid --layer-one 1024 --layer-two 1024 > out/l2_0.00003_1024_sigmoid.csv