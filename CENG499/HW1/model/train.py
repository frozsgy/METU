import os

import torch
import torchvision.transforms as T
import torch.nn.functional as F
from torch.utils.data import DataLoader
from dataset import MOADataset
from model import MyModel1, MyModel2, MyModel3
import time


def train(model, optimizer, dataloader, epochs, device):
    model.train()
    print("epoch_id,step_id,loss")
    for epoch_idx in range(epochs):
        i = 0
        for images, labels in dataloader:
            images = images.to(device)
            labels = labels.to(device)
            optimizer.zero_grad()
            pred = model(images)
            loss = F.nll_loss(pred, labels)
            loss.backward()
            optimizer.step()
            print(f"{epoch_idx:03},{i:03},{loss.item()}")
            i += 1
    filename = "models/" + str(int(time.time() * 1000)) + "-model_state_dict-"
    torch.save(model.state_dict(), filename)
    #print(f"Model saved: {filename}")


def train_with_val(model, optimizer, dataloader, validation_dataloader, epochs, device):
    model.train()
    print("epoch_id,step_id,loss,validation_loss")
    r = []
    rv = []
    rl = []
    for epoch_idx in range(epochs):
        i = 0
        losses = [0, 0]
        for images, labels in dataloader:
            images = images.to(device)
            labels = labels.to(device)
            optimizer.zero_grad()
            pred = model(images)
            loss = F.nll_loss(pred, labels)
            loss.backward()
            optimizer.step()
            r.append([epoch_idx, i, loss.item()])
            i += 1
            losses[0] = loss.item()
            #print(f"{epoch_idx:03},{i:03},{loss.item()}")
        i = 0
        for images, labels in validation_dataloader:
            images = images.to(device)
            labels = labels.to(device)
            model.eval()
            with torch.no_grad():
                pred = model(images)
                loss = F.nll_loss(pred, labels)
                validation_loss = loss.item()
            rv.append(validation_loss)
            losses[1] = loss.item()
            #print(f"{epoch_idx:03},{i:03},{loss.item()}")
            i += 1
        rl.append(tuple(losses))

    filename = "models/" + str(int(time.time() * 1000)) + "-model_state_dict-"
    torch.save(model.state_dict(), filename)
    #print(f"Model saved: {filename}")
    #print(r)
    #print(rv)
    """for i in r:
        print(f"{i[0]:03},{i[1]:03},{i[2]}")
    for i in rv:
        print(f"{i}")"""
    print("epoch, train_loss,validation_loss")
    i = 1
    for r in rl:
        print(f"{i},{r[0]},{r[1]}")
        i += 1


def main(use_cuda=False, epochs=100, lr=0.001, layers=0, l1=0, l2=0, f1="relu", f2="relu", val=False):
    device = torch.device('cuda' if use_cuda else 'cpu')
    torch.manual_seed(123)

    transforms = T.Compose([
        T.ToTensor(),
        T.Normalize((0.5,), (0.5,)),
    ])
    train_dataset = MOADataset('data', 'train', transforms)
    train_fold = 25000
    validation_fold = 5000
    train_data, validation_data = torch.utils.data.random_split(train_dataset, (train_fold, validation_fold))
    train_dataloader = DataLoader(train_data, batch_size=64, shuffle=True, num_workers=os.cpu_count())
    validation_dataloader = DataLoader(validation_data, batch_size=64, shuffle=True, num_workers=os.cpu_count())
    if layers == 0:
        model = MyModel1()
    elif layers == 1:
        model = MyModel2(l1, f1)
    else:
        model = MyModel3(l1, l2, f1, f2)

    model = model.to(device)

    optimizer = torch.optim.Adam(model.parameters(), lr=lr)

    if val is False:
        train(model, optimizer, train_dataloader, epochs, device)
    else:
        train_with_val(model, optimizer, train_dataloader, validation_dataloader, epochs, device)

    model.eval()
    train_correct = 0
    validation_correct = 0
    with torch.no_grad():
        for images, labels in train_dataloader:
            images = images.to(device)
            labels = labels.to(device)
            pred = model(images)
            pred_value, pred_indices = torch.max(pred, dim=1)
            c = len(labels)
            for i in range(c):
                if labels[i] == pred_indices[i]:
                    train_correct += 1
        for images, labels in validation_dataloader:
            images = images.to(device)
            labels = labels.to(device)
            pred = model(images)
            pred_value, pred_indices = torch.max(pred, dim=1)
            c = len(labels)
            for i in range(c):
                if labels[i] == pred_indices[i]:
                    validation_correct += 1
    print(f"Training correctness: {train_correct * 100. / train_fold}")
    print(f"Validation correctness: {validation_correct * 100. / validation_fold}")


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--cuda", help="enables cuda", action="store_true")
    parser.add_argument("-e", "--epochs", help="sets epoch value", nargs='?', const=100, type=int)
    parser.add_argument("-l", "--layers", help="sets hidden layer count", nargs='?', const=0, type=int)
    parser.add_argument("-lr", "--learning-rate", help="sets learning rate at optimizer", type=float)
    parser.add_argument("--layer-one", help="sets layer one activation", nargs='?', const=512, type=int)
    parser.add_argument("--layer-one-function", help="sets layer one function", type=str)
    parser.add_argument("--layer-two", help="sets layer two activation", nargs='?', const=512, type=int)
    parser.add_argument("--layer-two-function", help="sets layer two function", type=str)
    parser.add_argument("-v", "--validation-loss", help="calculates validation loss", action="store_true")
    args = parser.parse_args()
    epochs = 100 if args.epochs is None else args.epochs
    learning_rate = 0.001 if args.learning_rate is None else args.learning_rate
    if args.layers == 2:
        print(f"2 layered network - epochs: {epochs}, learning rate: {learning_rate}, layer one a: {args.layer_one}, "
              f"layer two a: {args.layer_two}, layer one f: {args.layer_one_function}, layer two f: {args.layer_two_function}")
        main(args.cuda, epochs, learning_rate, args.layers, args.layer_one, args.layer_two,
             args.layer_one_function, args.layer_two_function, args.validation_loss)
    elif args.layers == 1:
        print(f"1 layered network - epochs: {epochs}, learning rate: {learning_rate}, layer one a: {args.layer_one}, "
              f"layer one f: {args.layer_one_function}")
        main(args.cuda, epochs, learning_rate, args.layers, args.layer_one, 0, args.layer_one_function, val=args.validation_loss)
    else:
        print(f"0 layered network - epochs: {epochs}, learning rate: {learning_rate}")
        main(args.cuda, epochs, learning_rate, 0, val=args.validation_loss)

