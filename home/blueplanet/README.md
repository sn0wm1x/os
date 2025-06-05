# [Blue Planet](https://youtu.be/-2KzcaiyBFo)

A770 推理服务器

## 基础系统

安装最新版 Ubuntu Server：

https://ubuntu.com/tutorials/install-ubuntu-server

## 安装 GPGPU 环境

### 安装 GPU 驱动

> 在这里只需要 `compute-related`。

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository -y ppa:kobuk-team/intel-graphics
# compute-related
sudo apt install libze-intel-gpu1 libze1 intel-metrics-discovery intel-opencl-icd clinfo intel-gsc
# media-related
sudo apt install intel-media-va-driver-non-free libmfx-gen1 libvpl2 libvpl-tools libva-glx2 va-driver-all vainfo
# pytorch
sudo apt install libze-dev intel-ocloc
# ray-tracking
sudo apt install libze-intel-gpu-raytracing
```

### 安装 Intel oneAPI Base Toolkit

```bash
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

sudo apt update

sudo apt install intel-oneapi-base-toolkit
```

### 安装 intel-gpu-tools

```bash
sudo apt install intel-gpu-tools 
```

之后可以通过 `sudo intel_gpu_top` 查看显卡运行状态。

### 安装 xpu-smi

```bash
sudo apt install xpu-smi
```

之后可以通过 `xpu-smi` 查看和配置显卡，例如 `xpu-smi discovery -d 0`。

### 将当前用户添加到 render / video 组

```bash
sudo usermod -aG render $USER
sudo usermod -aG video $USER
```

### 测试

激活 oneAPI：`. /opt/intel/oneapi/setvars.sh`

通过 `clinfo` 测试 GPU 是否已识别：`clinfo | grep "Device Name"`

通过 `sycl-ls` 测试 GPU 是否已识别：`sycl-ls`

## 安装 Nix

这里使用 [Determine Nix Installer](https://determinate.systems/nix-installer)：

```bash
# determine nix: no
# nix install plan: yes
curl -sSf -L https://install.determinate.systems/nix | sudo sh -s -- install
```

## 安装环境

```bash
# 克隆到 ~/.os
cd ~ && git clone https://github.com/sn0wm1x/os.git .os
# 激活配置
```
