#!/bin/bash

#ENV=dev
#REGISTRY=nexus.company.pt

#cd ..
# Check if target and env has been given
if [[ ! "$1" ]]; then
  echo "Usage: build.sh build|publish"
  exit 1
fi

PROJECT="monitoring-grafana"
if [[ ! "${VERSION}" ]]; then
  VERSION=`cat version.txt`
fi

TARGET=$1

if [[ ! "${ENV}" ]]; then
  ENV="local"
fi

if [[ ! "${REGISTRY}" ]]; then
  REGISTRY="nexus.company.pt"
fi

docker build --progress plain --build-arg ENV=${ENV} -f ./builds/Dockerfile --tag ${REGISTRY}/monitoring/grafana:${VERSION} --tag ${REGISTRY}/monitoring/grafana:latest .

if [[ "${TARGET}" == "publish" ]]; then
  echo ${REGISTRY_USR_PASS} | docker login ${REGISTRY} -u ${REGISTRY_USR_NAME} --password-stdin
  docker push ${REGISTRY}/monitoring/grafana:${VERSION}
  docker push ${REGISTRY}/monitoring/grafana:latest
  docker logout ${REGISTRY}
fi

