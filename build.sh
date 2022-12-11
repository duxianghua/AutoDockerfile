#!/usr/bin/env bash
#GET Dockerfile List
set -euxo pipefail
REPO_PREFIX="xingba"
# DockerfileList=$(git diff-tree --no-commit-id --name-only -n 1 HEAD~1..HEAD  -r --diff-filter=ACMR)
echo $(git diff-tree --no-commit-id --name-only -r --diff-filter=ACMR HEAD)
DockerfileList=$(git diff-tree --no-commit-id --name-only -r --diff-filter=ACMR HEAD)
for i in $DockerfileList
do
    REPOPATH=$(dirname $i)
    DOCKEFILE=${i##*/}
    TAG=${DOCKEFILE#*.}
    IMAGE_REPO_FULL_URL="${REPO_PREFIX}/${REPOPATH}:${TAG}"
    
    echo "docker build -t ${IMAGE_REPO_FULL_URL} -f $(pwd)/${i} $(pwd)/${REPOPATH}"
    docker build -t ${IMAGE_REPO_FULL_URL} -f ${i} ./${REPOPATH} && docker push ${IMAGE_REPO_FULL_URL}
done
