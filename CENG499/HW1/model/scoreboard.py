import os

import torch
import torchvision.transforms as T
from torch.utils.data import DataLoader

from dataset import MOADataset
from model import MyModel3

model = MyModel3(512, 512, 'relu', 'relu')
model.load_state_dict(torch.load('1619313386951-model_state_dict-', map_location=torch.device('cpu')))
model.eval()

transforms = T.Compose([
    T.ToTensor(),
    T.Normalize((0.5,), (0.5,)),
])

test_dataset = MOADataset('data', 'test', transforms)
test_data_loader = DataLoader(test_dataset, batch_size=30000, num_workers=os.cpu_count())

predicted_labels = None
for images, labels in test_data_loader:
    out = model(images)
    q, predicted_labels = torch.max(out, 1)
with open('mylabels-l2-relu-512.txt', 'w+') as f:
    for j in range(30000):
        f.write(f"{j:06}.png {predicted_labels[j]}\n")
