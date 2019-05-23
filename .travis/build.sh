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
