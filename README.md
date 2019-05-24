# <img src="/icons/container.png" width="60" vertical-align="bottom"> Singularity Containers

## Welcome to SAMITorch
<!--
[![Build Status](https://travis-ci.com/sami-ets/SAMITorch.svg?branch=master)](https://travis-ci.com/sami-ets/SAMITorch)
![GitHub All Releases](https://img.shields.io/github/downloads/sami-ets/SAMITorch/total.svg)
![GitHub issues](https://img.shields.io/github/issues/sami-ets/SAMITorch.svg)
![GitHub](https://img.shields.io/github/license/sami-ets/SAMITorch.svg)
![GitHub contributors](https://img.shields.io/github/contributors/sami-ets/SAMITorch.svg) -->

This repository regroups multiple Singularity containers recipes for building and compiling high performance Python libraries used in various deep learning usage such as OpenCV, PyTorch and TensorFlow. These recipes are currently deployed in [École de technologie supérieure](https://www.etsmtl.ca/) in Software Engineering computer laboratories and research servers.

This repository aims at keeping various versions of these libraries compiled in Singularity containers with all necessary libraries for a common usage of them.  

# Table Of Contents

-  [Authors](#authors)
-  [References](#references)
-  [Project architecture](#project-architecture)
    -  [Folder structure](#folder-structure)
    -  [Main Components](#main-components)
 -  [Contributing](#contributing)
 -  [Branch naming](#branch-naming)
 -  [Commits syntax](#commits-syntax)
 -  [Acknowledgments](#acknowledgments)


## Authors

* Patrice Dion
* Pierre-Luc Delisle - [pldelisle](https://github.com/pldelisle)


## References

#### Web links:

##### NVIDIA
https://docs.nvidia.com/cuda/archive/9.2/cuda-installation-guide-linux/index.html
https://docs.nvidia.com/cuda/archive/10.0/cuda-installation-guide-linux/index.html
https://docs.nvidia.com/cuda/archive/10.1/cuda-installation-guide-linux/index.html
https://devblogs.nvidia.com/gpu-containers-runtime/
https://www.nvidia.com/object/unix.html
https://developer.nvidia.com/nccl
https://developer.nvidia.com/cudnn

##### Singularity
https://github.com/sylabs/singularity/issues/1292
https://singularity.lbl.gov/docs-recipes#best-practices-for-build-recipes

##### OpenCV
https://github.com/opencv/opencv/wiki/CPU-optimizations-build-optionsy

##### Various
https://gist.github.com/raulqf/a3caa97db3f8760af33266a1475d0e5e
https://github.com/BVLC/caffe/wiki/OpenCV-3.2-Installation-Guide-on-Ubuntu-16.04

## Setup
#### Building the container (with CUDA support)

> singularity build <container-name>.simg  <path/to/container-name>.def
> singularity shell --nv <container-name>.simg

#### Building the container (without CUDA support)

> singularity build <container-name>.simg  <path/to/container-name>.def
> singularity shell <container-name>.simg


## Project architecture
### Folder structure

```
├── .travis                 - Contains Travis-CI files to automatically build containers on Travis' infrastructure.
|
├── icons                   - Contains project's artwork.
|
├── opencv                  - OpenCV containers.
│   ├── opencv-3.4.6-cuda-9.2-Ubuntu-18.04-amd64.def.def                  - CUDA enabled OpenCV container.
│   └── opencv-3.4.6-Ubuntu-18.04-amd64.def.def                           - x86-64 optimized OpenCV container.
|
├── pytorch                 - PyTorch containers.
|   └── .def
|
├── tensorflow              - Tensorflow containers.
|   └── .def
```

### Continuous integration

As of now, Travis-CI automatic building works. Unfortunately, the free package doesn't allow more than 50 minutes for a build. After that time, builds will fail. This repository is ready for a paid Travis-CI package where the option for unlimited minutes for building are included.

Bamboo server is configured for building containers on a private server : pldelisle.no-ip.info:8086. This Bamboo server runs in a Docker container where Golang and Singularity are both installed.

To run this container :
> docker run -v /home/pierre-luc-delisle/Documents/bamboo:/var/atlassian/application-data/bamboo --name="bamboo-server" --privileged -d -p 54663:54663 -p 8086:8085 --restart always pldelisle/bamboo-server-singularity

Image is stored on [Dockerhub](https://cloud.docker.com/u/pldelisle/repository/docker/pldelisle/bamboo-server-singularity)

## Contributing
If you find a bug or have an idea for an improvement, please follow this procedure:
- [X] Create a branch by feature and/or bug fix
- [X] Get the code
- [X] Commit and push
- [X] Create a pull request

## Branch naming

| Instance        | Branch                                              | Description, Instructions, Notes                   |
|-----------------|-----------------------------------------------------|----------------------------------------------------|
| Stable          | stable                                              | Accepts merges from Development and Hotfixes       |
| Development     | dev/ [Short description] [Issue number]             | Accepts merges from Features / Issues and Hotfixes |
| Features/Issues | feature/ [Short feature description] [Issue number] | Always branch off HEAD or dev/                     |
| Hotfix          | fix/ [Short feature description] [Issue number]     | Always branch off Stable                           |

## Commits syntax

##### Adding code:
> \+ Added [Short Description] [Issue Number]

##### Deleting code:
> \- Deleted [Short Description] [Issue Number]

##### Modifying code:
> \* Changed [Short Description] [Issue Number]

##### Merging branches:
> Y Merged [Short Description]

## Acknowledgment
Thanks to [École de technologie supérieure](https://www.etsmtl.ca/) and Patrice Dion for providing recipes for these containers.

Icons made by <a href="http://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
