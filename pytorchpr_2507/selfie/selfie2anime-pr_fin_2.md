# Selfie to Anime Project
## Code 0. Import Library
```python
# !pip install Pillow --upgrade
```

```python
import torch

print("🌟 PyTorch 버전:", torch.__version__)
print("🧠 CUDA 버전:", torch.version.cuda)
print("⚡ CUDA 사용 가능?:", torch.cuda.is_available())

if torch.cuda.is_available():
    print("🚀 GPU 이름:", torch.cuda.get_device_name(0))
else:
    print("❌ CUDA 사용 불가 (CPU 모드로 동작 중)")
```

```python
import glob
import random
import os

from torch.utils.data import Dataset, DataLoader
from PIL import Image
import torchvision.transforms as transforms
import sys
import torch.nn as nn
import torch.nn.functional as F
import torch

import os
import numpy as np
import math
import itertools
import datetime
import time

from torchvision.utils import save_image, make_grid
from torchvision import datasets
from torch.autograd import Variable
```

## 주요 모듈 및 라이브러리 상세 리스트

| 모듈 / 라이브러리                      | 주요 용도 및 역할                                                                                                                    |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **torch**                       | PyTorch 핵심 패키지 - 텐서 연산, GPU 연산 처리, 자동 미분(autograd) 등 딥러닝 프레임워크의 기반 기능 제공                                                      |
| **glob**                        | 파일 시스템에서 와일드카드(\*)를 이용한 경로 검색 - trainA, trainB 디렉터리 내 이미지 파일 목록 수집에 사용                                                        |
| **random**                      | 파이썬 내장 난수 생성기 - unaligned=True일 때 A↔B 페어를 랜덤 매칭하거나, ReplayBuffer 내 샘플을 랜덤 교체하는 데 활용                                           |
| **os**                          | 운영체제 파일/디렉터리 경로 조작 및 생성(os.path, os.makedirs) - 작업 디렉터리 확인(os.getcwd()), 파일 리스트 나열(os.listdir()) 등에 사용                        |
| **torch.utils.data.Dataset**    | PyTorch 데이터셋 인터페이스 정의용 추상 클래스 - 커스텀 ImageDataset 구현 시 **getitem**, **len** 메서드 표준화                                            |
| **torch.utils.data.DataLoader** | Dataset을 배치(batch) 단위로 로드, 셔플, 멀티프로세스 병렬 읽기 지원 - batch\_size, shuffle, num\_workers 파라미터로 학습 효율 최적화                           |
| **PIL.Image**                   | Python Imaging Library (Pillow) - 다양한 포맷(JPEG, PNG, BMP 등)의 이미지 입출력 - 회색조→RGB 변환(to\_rgb) 등에 사용                               |
| **torchvision.transforms**      | 이미지 전처리(Resize, RandomCrop, RandomHorizontalFlip, ToTensor, Normalize) 파이프라인 구축 - 데이터 증강(data augmentation) 및 Tensor 변환 기능 제공 |
| **sys**                         | 표준 입출력, 인코딩 설정 - stdout.write, stdout.flush로 실시간 학습 로그(프로그레스바) 출력 제어                                                          |
| **torch.nn**                    | 신경망 레이어(Conv2d, InstanceNorm2d, ReflectionPad2d 등)와 모듈(nn.Module) 제공 - GeneratorResNet, Discriminator, ResidualBlock 구현에 사용   |
| **torch.nn.functional**         | 활성화 함수(ReLU, LeakyReLU), 손실 함수(F.l1\_loss 등) 호출용 - 모듈화된 레이어(nn.Module)보다 직접 함수 호출을 선호할 때 활용                                   |
| **numpy (np)**                  | 수치 계산 라이브러리 - 데이터 타입 변환, 배열 연산, 통계량 계산 등에 활용                                                                                  |
| **math**                        | 파이썬 내장 수학 함수(ceil, floor, sqrt 등) - 반복횟수 계산, 이미지 크기 비율 계산 등 소수점 처리에 사용                                                        |
| **itertools**                   | 이터레이터 유틸리티(chain, cycle, product 등) - 생성자 파라미터 집합을 chain(G\_AB.parameters(), G\_BA.parameters())로 묶어서 옵티마이저에 전달               |
| **datetime**                    | 시간 정보 계산 및 포매팅 - 학습 ETA(Estimated Time of Arrival) 계산, 체크포인트 파일명에 타임스탬프 삽입 등에 활용                                              |
| **time**                        | 초 단위 시간 측정(time.time())으로 배치 처리 시간 프로파일링 - 실시간 성능 모니터링                                                                        |
| **torchvision.utils**           | 생성된 이미지 시각화 및 저장 - make\_grid로 다중 이미지를 격자(grid) 형태로 결합 후 save\_image로 파일 저장                                                   |
| **torchvision.datasets**        | 내장 데이터셋 API (MNIST, CIFAR 등) - 예시에서는 사용되지 않더라도 표준화된 데이터셋 로딩 인터페이스 제공                                                          |
| **torch.autograd.Variable**     | 과거 PyTorch 버전 호환용 래퍼 클래스 - requires\_grad 설정 및 그래디언트 추적을 위한 텐서 래핑                                                             |
| **multiprocessing**             | 병렬 데이터 로딩(num\_workers) 최적화 전 CPU 코어 수 확인 - min(4, cpu\_count())로 멀티 스레드/프로세스 활용도 제어                                          |
| **torch.amp.GradScaler**        | 자동 혼합 정밀도(Mixed Precision) 학습 지원 - scaler.scale, scaler.step, scaler.update로 손실 스케일링 및 언스케일링 처리                               |

## Code 1. Dataset
```python
def to_rgb(image):
    rgb_image = Image.new("RGB", image.size)
    rgb_image.paste(image)
    return rgb_image
```

## PyTorch 커스텀 Dataset 구성
●	__init__(): 이미지 경로 설정 및 전처리 파이프라인 정의

●	__getitem__(index): A/B 도메인의 이미지 한 쌍 반환

●	__len__(): max(len(A), len(B)) 반환 → 긴 도메인 기준으로 반복

특징:  
●	A, B 간 데이터 수 불일치 시 부족한 쪽을 반복 사용

●	불균형 보완 + 데이터 증강 효과


```python
class ImageDataset(Dataset):
    def __init__(self, root, transforms_=None, unaligned=False, mode="train"):
        self.transform = transforms.Compose(transforms_)
        self.unaligned = unaligned
        # train 모드일 때는 trainA, trainB에 있는 디렉토리에서 이미지를 불러옵니다. 
        if mode=="train":
            # glob 함수로 trainA 디렉토리의 이미지의 목록을 불러옵니다. 
            self.files_A = sorted(glob.glob(os.path.join(root, "trainA") + "/*.*"))
            self.files_B = sorted(glob.glob(os.path.join(root, "trainB") + "/*.*"))
        else:
            self.files_A = sorted(glob.glob(os.path.join(root, "testA") + "/*.*"))
            self.files_B = sorted(glob.glob(os.path.join(root, "testB") + "/*.*"))

    def __getitem__(self, index):
        # index값으로 이미지의목록 중 이미지 하나를 불러옵니다. 
        image_A = Image.open(self.files_A[index % len(self.files_A)])
        # unaligned 변수로 학습할 Pair를 랜덤으로 고릅니다.  
        if self.unaligned:
            image_B = Image.open(self.files_B[random.randint(0, len(self.files_B) - 1)])
        else:
            image_B = Image.open(self.files_B[index % len(self.files_B)])

        # Convert grayscale images to rgb
        if image_A.mode != "RGB":
            image_A = to_rgb(image_A)
        if image_B.mode != "RGB":
            image_B = to_rgb(image_B)

        item_A = self.transform(image_A)
        item_B = self.transform(image_B)
        return {"A": item_A, "B": item_B}

    def __len__(self):
        return max(len(self.files_A), len(self.files_B))
```

## Code 2. Generator & Discriminator


```python
def weights_init_normal(m):
    classname = m.__class__.__name__
    if classname.find("Conv") != -1:
        torch.nn.init.normal_(m.weight.data, 0.0, 0.02)
        if hasattr(m, "bias") and m.bias is not None:
            torch.nn.init.constant_(m.bias.data, 0.0)
    elif classname.find("BatchNorm2d") != -1:
        torch.nn.init.normal_(m.weight.data, 1.0, 0.02)
        torch.nn.init.constant_(m.bias.data, 0.0)
```

```python
class ResidualBlock(nn.Module):
    def __init__(self, in_features):
        super(ResidualBlock, self).__init__()

        self.block = nn.Sequential(
            nn.ReflectionPad2d(1),
            nn.Conv2d(in_features, in_features, 3),
            nn.InstanceNorm2d(in_features),
            nn.ReLU(inplace=True),
            nn.ReflectionPad2d(1),
            nn.Conv2d(in_features, in_features, 3),
            nn.InstanceNorm2d(in_features),
        )

    def forward(self, x):
        return x + self.block(x)
```

```python
class GeneratorResNet(nn.Module):
    def __init__(self, input_shape, num_residual_blocks):
        super(GeneratorResNet, self).__init__()

        channels = input_shape[0]

        # Initial convolution block
        out_features = 64
        model = [
            nn.ReflectionPad2d(channels),
            nn.Conv2d(channels, out_features, 7),
            nn.InstanceNorm2d(out_features),
            nn.ReLU(inplace=True),
        ]
        in_features = out_features

        # Downsampling
        for _ in range(2):
            out_features *= 2
            model += [
                nn.Conv2d(in_features, out_features, 3, stride=2, padding=1),
                nn.InstanceNorm2d(out_features),
                nn.ReLU(inplace=True),
            ]
            in_features = out_features

        # Residual blocks
        for _ in range(num_residual_blocks):
            model += [ResidualBlock(out_features)]

        # Upsampling
        for _ in range(2):
            out_features //= 2
            model += [
                nn.Upsample(scale_factor=2),
                nn.Conv2d(in_features, out_features, 3, stride=1, padding=1),
                nn.InstanceNorm2d(out_features),
                nn.ReLU(inplace=True),
            ]
            in_features = out_features

        # Output layer
        model += [nn.ReflectionPad2d(channels), nn.Conv2d(out_features, channels, 7), nn.Tanh()]

        self.model = nn.Sequential(*model)

    def forward(self, x):
        return self.model(x)
```

```python
class Discriminator(nn.Module):
    def __init__(self, input_shape):
        super(Discriminator, self).__init__()

        channels, height, width = input_shape

        # Calculate output shape of image discriminator (PatchGAN)
        self.output_shape = (1, height // 2 ** 4, width // 2 ** 4)

        def discriminator_block(in_filters, out_filters, normalize=True):
            """Returns downsampling layers of each discriminator block"""
            layers = [nn.Conv2d(in_filters, out_filters, 4, stride=2, padding=1)]
            if normalize:
                layers.append(nn.InstanceNorm2d(out_filters))
            layers.append(nn.LeakyReLU(0.2, inplace=True))
            return layers

        self.model = nn.Sequential(
            *discriminator_block(channels, 64, normalize=False),
            *discriminator_block(64, 128),
            *discriminator_block(128, 256),
            *discriminator_block(256, 512),
            nn.ZeroPad2d((1, 0, 1, 0)),
            nn.Conv2d(512, 1, 4, padding=1)
        )

    def forward(self, img):
        return self.model(img)
```

## Code 3. Training
```python
# 수동으로 출력 결과가 저장될 폴더 이름을 지정해줌

dataset_name = "selfie2anime3"

channels = 3
img_height = 256
img_width = 256
n_residual_blocks=9
lr=0.0002
b1=0.5
b2=0.999
n_epochs=200
init_epoch=0
decay_epoch=100
lambda_cyc=10.0
lambda_id=5.0
n_cpu=8
batch_size=1
sample_interval=100
checkpoint_interval=5
```

```python
# Create sample and checkpoint directories
os.makedirs("images/%s" % dataset_name, exist_ok=True)
os.makedirs("saved_models/%s" % dataset_name, exist_ok=True)
```

```python
# Losses
criterion_GAN = torch.nn.MSELoss()
criterion_cycle = torch.nn.L1Loss()
criterion_identity = torch.nn.L1Loss()
```

```python
input_shape = (channels, img_height, img_width)

# Initialize generator and discriminator
G_AB = GeneratorResNet(input_shape, n_residual_blocks)
G_BA = GeneratorResNet(input_shape, n_residual_blocks)
D_A = Discriminator(input_shape)
D_B = Discriminator(input_shape)
```

```python
cuda = torch.cuda.is_available()
if cuda:
    G_AB = G_AB.cuda()
    G_BA = G_BA.cuda()
    D_A = D_A.cuda()
    D_B = D_B.cuda()
    criterion_GAN.cuda()
    criterion_cycle.cuda()
    criterion_identity.cuda()
```

```python
# Initialize weights
G_AB.apply(weights_init_normal)
G_BA.apply(weights_init_normal)
D_A.apply(weights_init_normal)
D_B.apply(weights_init_normal)
```

```python
# Optimizers
optimizer_G = torch.optim.Adam(
    itertools.chain(G_AB.parameters(), G_BA.parameters()), lr=lr, betas=(b1, b2)
)
optimizer_D_A = torch.optim.Adam(D_A.parameters(), lr=lr, betas=(b1, b2))
optimizer_D_B = torch.optim.Adam(D_B.parameters(), lr=lr, betas=(b1, b2))
```

```python
class LambdaLR:
    def __init__(self, n_epochs, offset, decay_start_epoch):
        assert (n_epochs - decay_start_epoch) > 0, "Decay must start before the training session ends!"
        self.n_epochs = n_epochs
        self.offset = offset
        self.decay_start_epoch = decay_start_epoch

    def step(self, epoch):
        return 1.0 - max(0, epoch + self.offset - self.decay_start_epoch) / (self.n_epochs - self.decay_start_epoch)
```

```python
# Learning rate update schedulers
lr_scheduler_G = torch.optim.lr_scheduler.LambdaLR(
    optimizer_G, lr_lambda=LambdaLR(n_epochs, init_epoch, decay_epoch).step
)
lr_scheduler_D_A = torch.optim.lr_scheduler.LambdaLR(
    optimizer_D_A, lr_lambda=LambdaLR(n_epochs, init_epoch, decay_epoch).step
)
lr_scheduler_D_B = torch.optim.lr_scheduler.LambdaLR(
    optimizer_D_B, lr_lambda=LambdaLR(n_epochs, init_epoch, decay_epoch).step
)
```

```python
cuda = torch.cuda.is_available()
Tensor = torch.cuda.FloatTensor if cuda else torch.FloatTensor

Tensor = torch.cuda.FloatTensor if cuda else torch.Tensor
```

```python
class ReplayBuffer:
    def __init__(self, max_size=50):
        assert max_size > 0, "Empty buffer or trying to create a black hole. Be careful."
        self.max_size = max_size
        self.data = []

    def push_and_pop(self, data):
        to_return = []
        for element in data.data:
            element = torch.unsqueeze(element, 0)
            if len(self.data) < self.max_size:
                self.data.append(element)
                to_return.append(element)
            else:
                if random.uniform(0, 1) > 0.5:
                    i = random.randint(0, self.max_size - 1)
                    to_return.append(self.data[i].clone())
                    self.data[i] = element
                else:
                    to_return.append(element)
        return Variable(torch.cat(to_return))
```

```python
# Buffers of previously generated samples
fake_A_buffer = ReplayBuffer()
fake_B_buffer = ReplayBuffer()
```

```python
# Image transformations
transforms_ = [
    transforms.Resize(int(img_height * 1.12), Image.BICUBIC),
    transforms.RandomCrop((img_height, img_width)),
    transforms.RandomHorizontalFlip(),
    transforms.ToTensor(),
    transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5)),
]
```

```python
# 중간 확인 작업


print(dataset_name)
import os
print("Current working directory:", os.getcwd())
import os
print(os.listdir("./dataset"))

print(os.listdir("./"))
```

```python
import multiprocessing # 추가함

# CPU 코어 수를 기준으로 최대 4개까지만 사용
n_cpu = min(4, multiprocessing.cpu_count()) # 추가함

# 이후 DataLoader에서 그대로 사용
dataloader = DataLoader(
    ImageDataset("./dataset", transforms_=transforms_, unaligned=True),
    batch_size=batch_size,
    shuffle=True,
    num_workers=0,  # 여기서 적용됨
)

val_dataloader = DataLoader(
    ImageDataset("./dataset", transforms_=transforms_, unaligned=True, mode="test"),
    batch_size=5,
    shuffle=True,
    num_workers=0,
)
```

```python
def sample_images(batches_done):
    """Saves a generated sample from the test set"""
    imgs = next(iter(val_dataloader))
    G_AB.eval()
    G_BA.eval()
    real_A = Variable(imgs["A"].type(Tensor))
    fake_B = G_AB(real_A)
    real_B = Variable(imgs["B"].type(Tensor))
    fake_A = G_BA(real_B)

    # Arange images along x-axis
    real_A = make_grid(real_A, nrow=5, normalize=True)
    real_B = make_grid(real_B, nrow=5, normalize=True)
    fake_A = make_grid(fake_A, nrow=5, normalize=True)
    fake_B = make_grid(fake_B, nrow=5, normalize=True)
    
    # Arange images along y-axis
    image_grid = torch.cat((real_A, fake_B, real_B, fake_A), 1)
    save_image(image_grid, "images/%s/%s.png" % (dataset_name, batches_done), normalize=False)
```

```python
from torch.amp import GradScaler  # ← 변경된 위치에서 가져오기
scaler = GradScaler(device="cuda")  # ← device 명시
```

# 모델 3:  AMD 모델 처럼 모델 결과물을 가로 배열로 보이게 하기 

그래픽카드 : nvidia, 에폭수 : 70, 데이터셋 이름: dataset_n3
```python
import torch
from torch.autograd import Variable
from torch.amp import GradScaler
from torch.cuda.amp import autocast # <-- 다시 이 임포트로 변경합니다.

import numpy as np
import datetime
import time
import sys

# ✅ [수정] 학습 epoch 수 변경
n_epochs = 70  

# device 설정
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)

 # --- GPU 정보 출력 ---
print(torch.__version__)
print(torch.version.cuda)
print(torch.cuda.is_available())
print("CUDA 사용 가능 여부:", torch.cuda.is_available())
if torch.cuda.is_available():
    print("사용 중인 GPU 이름:", torch.cuda.get_device_name(0))
    print("CUDA 디바이스 수:", torch.cuda.device_count())
    print("현재 디바이스 번호:", torch.cuda.current_device())


# cuDNN 최적화
torch.backends.cudnn.benchmark = True

# 모델을 device로 이동
G_AB = G_AB.to(device)
G_BA = G_BA.to(device)
D_A = D_A.to(device)
D_B = D_B.to(device)

# 손실 함수도 device로 이동
criterion_GAN = criterion_GAN.to(device)
criterion_cycle = criterion_cycle.to(device)
criterion_identity = criterion_identity.to(device)

# Mixed Precision Training을 위한 준비
scaler = GradScaler(device="cuda")

# 체크포인트 및 이미지 저장 설정
checkpoint_interval = 10
sample_interval = 100
init_epoch = 0

prev_time = time.time()
for epoch in range(init_epoch, n_epochs):
    for i, batch in enumerate(dataloader):

        # 모델 입력 준비 (device로 이동)
        real_A = batch["A"].to(device)
        real_B = batch["B"].to(device)

        # 진짜/가짜 판별 라벨 생성
        valid = torch.ones((real_A.size(0), *D_A.output_shape), device=device, dtype=torch.float32, requires_grad=False)
        fake = torch.zeros((real_A.size(0), *D_A.output_shape), device=device, dtype=torch.float32, requires_grad=False)

        # 생성자 학습
        G_AB.train()
        G_BA.train()
        optimizer_G.zero_grad()
        
        # --- [필수 정의 끝] --------------------------------------------
        
        

        # Mixed Precision: autocast()를 인자 없이 사용하거나,
        #                   dtype=torch.float16 (또는 torch.bfloat16)과 같이 사용합니다.
        #                   여기서는 가장 기본적인 인자 없는 형태로 변경합니다.
        with autocast(): # <-- 이 부분을 이렇게 변경합니다. (인자 제거)
            # 아이덴티티 손실
            loss_id_A = criterion_identity(G_BA(real_A), real_A)
            loss_id_B = criterion_identity(G_AB(real_B), real_B)
            loss_identity = (loss_id_A + loss_id_B) / 2

            # GAN 손실
            fake_B = G_AB(real_A)
            loss_GAN_AB = criterion_GAN(D_B(fake_B), valid)
            fake_A = G_BA(real_B)
            loss_GAN_BA = criterion_GAN(D_A(fake_A), valid)
            loss_GAN = (loss_GAN_AB + loss_GAN_BA) / 2

            # 사이클 일관성 손실
            recov_A = G_BA(fake_B)
            loss_cycle_A = criterion_cycle(recov_A, real_A)
            recov_B = G_AB(fake_A)
            loss_cycle_B = criterion_cycle(recov_B, real_B)
            loss_cycle = (loss_cycle_A + loss_cycle_B) / 2

            # 전체 생성자 손실
            loss_G = loss_GAN + lambda_cyc * loss_cycle + lambda_id * loss_identity

        scaler.scale(loss_G).backward()
        scaler.step(optimizer_G)
        scaler.update()

        # 판별자 A 학습
        optimizer_D_A.zero_grad()
        with autocast(): # <-- 이 부분도 이렇게 변경합니다. (인자 제거)
            loss_real = criterion_GAN(D_A(real_A), valid)
            fake_A_ = fake_A_buffer.push_and_pop(fake_A)
            loss_fake = criterion_GAN(D_A(fake_A_.detach()), fake)
            loss_D_A = (loss_real + loss_fake) / 2

        scaler.scale(loss_D_A).backward()
        scaler.step(optimizer_D_A)
        scaler.update()

        # 판별자 B 학습
        optimizer_D_B.zero_grad()
        with autocast(): # <-- 이 부분도 이렇게 변경합니다. (인자 제거)
            loss_real = criterion_GAN(D_B(real_B), valid)
            fake_B_ = fake_B_buffer.push_and_pop(fake_B)
            loss_fake = criterion_GAN(D_B(fake_B_.detach()), fake)
            loss_D_B = (loss_real + loss_fake) / 2

        scaler.scale(loss_D_B).backward()
        scaler.step(optimizer_D_B)
        scaler.update()

        # 전체 판별자 손실
        loss_D = (loss_D_A + loss_D_B) / 2

        # 남은 시간 계산
        batches_done = epoch * len(dataloader) + i
        batches_left = n_epochs * len(dataloader) - batches_done
        time_left = datetime.timedelta(seconds=batches_left * (time.time() - prev_time))
        prev_time = time.time()

        # 로그 출력
        sys.stdout.write(
            "\r[Epoch %d/%d] [Batch %d/%d] [D loss: %.4f] [G loss: %.4f, adv: %.4f, cycle: %.4f, identity: %.4f] ETA: %s"
            % (
                epoch,
                n_epochs,
                i,
                len(dataloader),
                loss_D.item(),
                loss_G.item(),
                loss_GAN.item(),
                loss_cycle.item(),
                loss_identity.item(),
                time_left,
            )
        )
        sys.stdout.flush()

        # 이미지 저장
        if batches_done % sample_interval == 0:
            sample_images(batches_done)

    # 학습률 스케줄러 업데이트
    lr_scheduler_G.step()
    lr_scheduler_D_A.step()
    lr_scheduler_D_B.step()

    # 체크포인트 저장
    if checkpoint_interval != -1 and epoch % checkpoint_interval == 0:
        torch.save(G_AB.state_dict(), f"saved_models/{dataset_name}/G_AB_{epoch}.pth")
        torch.save(G_BA.state_dict(), f"saved_models/{dataset_name}/G_BA_{epoch}.pth")
        torch.save(D_A.state_dict(), f"saved_models/{dataset_name}/D_A_{epoch}.pth")
        torch.save(D_B.state_dict(), f"saved_models/{dataset_name}/D_B_{epoch}.pth")
```

```python

```

