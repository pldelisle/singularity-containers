#!/bin/bash
# Copyright 2019 Pierre-Luc Delisle. All Rights Reserved.
#
# Licensed under the MIT License;
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://opensource.org/licenses/MIT
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
#
#
# USAGE: build.sh --uri collection-name/container-name --cli registry Singularity
#        build.sh --uri collection-name/container-name --cli registry
#        build.sh Singularity


set -o errexit
set -o nounset

function usage() {

    echo "USAGE: build [recipe] [options]"
    echo ""
    echo "OPTIONS:
          Image Format
              --uri   -u    if uploading, a uri to give to sregistry
              --cli   -c    the sregistry client to use (if uploading)
              --help  -h    show this help and exit
              "
}

# --- Option processing --------------------------------------------------------

uri=""
cli=""
tag=""

while true; do
    case ${1:-} in
        -h|--help|help)
            usage
            exit 0
        ;;
        -u|-uri)
            shift
            uri="${1:-}"
            shift
        ;;
        -t|--tag)
            shift
            tag="${1:-}"
            shift
        ;;
        -c|--cli)
            shift
            cli="${1:-}"
            shift
        ;;
        \?) printf "illegal option: -%s\n" "${1:-}" >&2
            usage
            exit 1
        ;;
        -*)
            printf "illegal option: -%s\n" "${1:-}" >&2
            usage
            exit 1
        ;;
        *)
            break;
        ;;
    esac
done

################################################################################
### Recipe File ################################################################
################################################################################


if [ $# == 0 ] ; then
    recipe="Singularity"
else
    recipe=$1
fi

echo ""
echo "Image Recipe: ${recipe}"
if [ "${cli}" != "" ]; then
    echo "Storage Client: ${cli}"
fi


################################################################################
### Build! #####################################################################
################################################################################

# Continue if the image recipe is found

if [ -f "$recipe" ]; then

    imagefile="${recipe}.simg"

    echo "Creating $imagefile using $recipe..."

    wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda-repo-ubuntu1710-9-2-local_9.2.148-1_amd64 -O /tmp/cuda-repo-ubuntu1710-9-2-local_9.2.148-1_amd64.deb
    wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1710/x86_64/cuda-repo-ubuntu1710_9.2.148-1_amd64.deb  -O /tmp/cuda-repo-ubuntu1710_9.2.148-1_amd64.deb

    wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.0.56/prod/9.2_20190219/Ubuntu16_04-x64/libcudnn7_7.5.0.56-1%2Bcuda9.2_amd64.deb     -O /tmp/libcudnn7_7.5.0.56-1%2Bcuda9.2_amd64.deb
    wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.0.56/prod/9.2_20190219/Ubuntu16_04-x64/libcudnn7-dev_7.5.0.56-1%2Bcuda9.2_amd64.deb -O /tmp/libcudnn7-dev_7.5.0.56-1+cuda9.2_amd64.deb
    wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.0.56/prod/9.2_20190219/Ubuntu16_04-x64/libcudnn7-doc_7.5.0.56-1%2Bcuda9.2_amd64.deb -O /tmp/libcudnn7-doc_7.5.0.56-1+cuda9.2_amd64.deb

    wget https://developer.nvidia.com/compute/machine-learning/nccl/secure/v2.3/prod3/nccl-repo-ubuntu1604-2.3.7-ga-cuda9.2_1-1_amd64.deb  -O /tmp/nccl-repo-ubuntu1604-2.3.7-ga-cuda9.2_1-1_amd64.deb

    wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb -O /tmp/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb

    sudo singularity build $imagefile $recipe
    chmod +x $imagefile

    # If the image is successfully built, test it and upload (examples)

    if [ -f "${imagefile}" ]; then

        # Example testing using run (you could also use test command)

        sh $imagefile

        # Example sregistry commands to push to endpoints

        if [ "${cli}" != "" ]; then

            # If the uri isn't provided, he gets a robot name
            if [ "${uri}" == "" ]; then
                uri=$(python -c "from sregistry.logger.namer import RobotNamer; bot=RobotNamer(); print(bot.generate())")
            fi

            # If a tag is provided, add to uri
            if [ "${tag}" != "" ]; then
                uri="${uri}:${tag}"
            fi

            echo "Pushing ${uri} to ${cli}://"
            echo "SREGISTRY_CLIENT=${cli} sregistry push --name ${uri} ${imagefile}"
            SREGISTRY_CLIENT="${cli}" sregistry push --name "${uri}" "${imagefile}"

        else
            echo "Skipping upload. Image $imagefile is finished!"
        fi

    fi

else

    echo "Singularity recipe ${recipe} not found!"
    exit 1

fi
