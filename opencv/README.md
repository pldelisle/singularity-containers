# <img src="/icons/opencv.png" width="60" vertical-align="bottom"> OpenCV containers


# Table Of Contents

-  [Authors](#authors)
-  [Current Versions](#current-version)
-  [References](#references)
-  [Building containers](#building-containers)
-  [Running containers](#running-containers)


## Authors
* Patrice Dion
* Pierre-Luc Delisle - [pldelisle](https://github.com/pldelisle)

## Current version
* OpenCV 3.4.6
* NVIDIA CUDA 9.2
* GCC 7.2

## References

### To download CUDA 9.2
> `wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda-repo-ubuntu1710-9-2-local_9.2.148-1_amd64 -O /tmp/cuda-repo-ubuntu1710-9-2-local_9.2.148-1_amd64.deb  `  
> `wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1710/x86_64/cuda-repo-ubuntu1710_9.2.148-1_amd64.deb  -O /tmp/cuda-repo-ubuntu1710_9.2.148-1_amd64.deb  `  

### To download CUDNN
Need a download token directly from NVIDIA Developer Zone.
> `wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.0.56/prod/9.2_20190219/Ubuntu16_04-x64/libcudnn7_7.5.0.56-1%2Bcuda9.2_amd64.deb     -O /tmp/libcudnn7_7.5.0.56-1%2Bcuda9.2_amd64.deb  `
> `wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.0.56/prod/9.2_20190219/Ubuntu16_04-x64/libcudnn7-dev_7.5.0.56-1%2Bcuda9.2_amd64.deb -O /tmp/libcudnn7-dev_7.5.0.56-1+cuda9.2_amd64.deb  `
> `wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.0.56/prod/9.2_20190219/Ubuntu16_04-x64/libcudnn7-doc_7.5.0.56-1%2Bcuda9.2_amd64.deb -O /tmp/libcudnn7-doc_7.5.0.56-1+cuda9.2_amd64.deb  `

### To download NCCL
> `wget https://developer.nvidia.com/compute/machine-learning/nccl/secure/v2.3/prod3/nccl-repo-ubuntu1604-2.3.7-ga-cuda9.2_1-1_amd64.deb  -O /tmp/nccl-repo-ubuntu1604-2.3.7-ga-cuda9.2_1-1_amd64.deb  `

### To download the NVIDIA's Ubuntu repository
> `wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb -O /tmp/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb  `

### To use ÉTS internal Proxy server
Add line in the recipe under `%post` section.
> export SINGULARITY_HTTP_PROXY="http://proxy.logti.etsmtl.ca:3128"  

### Building OpenCV
https://github.com/opencv/opencv/wiki/CPU-optimizations-build-optionsy

### Various
https://gist.github.com/raulqf/a3caa97db3f8760af33266a1475d0e5e
https://github.com/BVLC/caffe/wiki/OpenCV-3.2-Installation-Guide-on-Ubuntu-16.04


## Building containers

#### Building the container (with CUDA support)

> singularity build <container-name>.simg  <path/to/container-name>.def  

#### Building the container (without CUDA support)

> singularity build <container-name>.simg  <path/to/container-name>.def  


## Running containers

#### With NVIDIA drivers
> singularity shell --nv <container-name>.simg  

#### Without NVIDIA drivers
> singularity shell <container-name>.simg  

## Notes
