VERSION := 4.0.3
NAME   := seqfu/oracle8-dragen-${VERSION}
TAG    := $$(git log -1 --pretty=%h)
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest
HOST   := $$(basename ${NAME})
PWD    := $$(pwd)

build:
	#docker build -t oracle8-rhck - < Dockerfile.rhck
	#docker build -t stage1 - < Dockerfile.1
	docker build -t ${IMG} .
	docker tag ${IMG} ${LATEST}
 
push:
	docker push ${NAME}

interact:
	docker run --rm -v "${PWD}:/host" --hostname ${HOST} --detach-keys="ctrl-@" -t -i ${LATEST} /bin/bash

interact_rhck:
	docker run --rm -v "${PWD}:/host" --hostname ${HOST} --detach-keys="ctrl-@" -t -i oracle8-rhck /bin/bash

run:
	docker run --rm ${LATEST} dragen

login:
	docker log -u ${DOCKER_USER} -p ${DOCKER_PASS}
