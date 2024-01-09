VERSION := 4.3.0-eng
NAME   := seqfu/oracle8-dragen-${VERSION}
TAG    := $$(git log -1 --pretty=%h)
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest
HOST   := $$(basename ${NAME})
PWD    := $$(pwd)

build:
	docker build -t ${IMG} .
	docker tag ${IMG} ${LATEST}
 
push:
	docker push ${NAME}

interact:
	docker run --rm -v "${PWD}:/host" --hostname ${HOST} --detach-keys="ctrl-@" -t -i ${LATEST} /bin/bash

run:
	docker run --rm ${LATEST} dragen

login:
	docker log -u ${DOCKER_USER} -p ${DOCKER_PASS}
