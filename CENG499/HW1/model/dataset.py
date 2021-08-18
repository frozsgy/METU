import os
from torch.utils.data import Dataset, DataLoader
from PIL import Image
import torchvision.transforms as T


class MOADataset(Dataset):

    data = []

    def __init__(self, dataset_path: str, split: str, transforms):
        self.transforms = transforms
        images_path = os.path.join(dataset_path, split)
        with open(os.path.join(images_path, 'labels.txt'), 'r') as f:
            for line in f:
                try:
                    image_name, label = line.split()
                except:
                    image_name, label = line.split()[0], 0
                image_path = os.path.join(images_path, image_name)
                label = int(label)
                self.data.append((image_path, label))

    def __len__(self):
        return len(self.data)

    def __getitem__(self, index):
        image_path, label = self.data[index]
        image = Image.open(image_path)
        image = self.transforms(image)
        return image, label


if __name__ == '__main__':
    transforms = T.Compose([
        T.ToTensor(),
        T.Normalize((0.5,), (0.5,)),
    ])
    dataset = MOADataset('data', 'train', transforms)
    dataloader = DataLoader(dataset, batch_size=64, shuffle=True, num_workers=4)
    for images, labels in dataloader:
        print(images.size())
        print(labels)
        exit()
    print(len(dataset))
    print(dataset[0])
