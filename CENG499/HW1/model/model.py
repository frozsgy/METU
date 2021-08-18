import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision.transforms as T
from torch.utils.data import DataLoader
from dataset import MOADataset


class MyModel1(nn.Module):
    def __init__(self):
        super(MyModel1, self).__init__()
        self.fc = nn.Linear(3 * 40 * 40, 10)

    def forward(self, x):
        x = x.view(x.size(0), -1)
        x = self.fc(x)
        x = torch.log_softmax(x, dim=1)
        return x


class MyModel2(nn.Module):
    def __init__(self, act: int, function: str):
        super(MyModel2, self).__init__()
        self.fc1 = nn.Linear(3 * 40 * 40, act)
        self.fc2 = nn.Linear(act, 10)
        self.f = function

    def forward(self, x):
        x = x.view(x.size(0), -1)
        x = self.fc1(x)
        if self.f == "tanh":
            x = F.tanh(x)
        elif self.f == "sigmoid":
            x = F.sigmoid(x)
        else:
            x = F.relu(x)
        x = self.fc2(x)
        x = torch.log_softmax(x, dim=1)
        return x


class MyModel3(nn.Module):
    def __init__(self, act1: int, act2: int, function1: str, function2: str):
        super(MyModel3, self).__init__()
        self.fc1 = nn.Linear(3 * 40 * 40, act1)
        self.fc2 = nn.Linear(act1, act2)
        self.fc3 = nn.Linear(act2, 10)
        self.f1 = function1
        self.f2 = function2

    def forward(self, x):
        x = x.view(x.size(0), -1)
        x = self.fc1(x)
        if self.f1 == "tanh":
            x = F.tanh(x)
        elif self.f1 == "sigmoid":
            x = F.sigmoid(x)
        else:
            x = F.relu(x)
        x = self.fc2(x)
        if self.f2 == "tanh":
            x = F.tanh(x)
        elif self.f2 == "sigmoid":
            x = F.sigmoid(x)
        else:
            x = F.relu(x)
        x = self.fc3(x)
        x = torch.log_softmax(x, dim=1)
        return x


if __name__ == '__main__':
    transforms = T.Compose([
        T.ToTensor(),
        T.Normalize((0.5,), (0.5,)),
    ])
    dataset = MOADataset('data', 'train', transforms)
    dataloader = DataLoader(dataset, batch_size=64, shuffle=True, num_workers=8)
    model = MyModel2(512, "relu")
    for images, labels in dataloader:
        pred = model(images)
        print(pred)
        exit()
