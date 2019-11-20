OWNER=carlosjgp
KUBECTL_VERSION=v1.16
ALPINE_VERSION=3.10.3

DOCKER_REPO=${OWNER}/kubectl
DOCKER_IMAGE=${DOCKER_REPO}:${KUBECTL_VERSION}

LATEST=false

default: push

build:
	docker build \
		-t ${DOCKER_IMAGE} \
		-t ${DOCKER_IMAGE}-alpine${ALPINE_VERSION} \
		--build-arg KUBECTL_VERSION=${KUBECTL_VERSION} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		.

push: build
	docker push ${DOCKER_IMAGE}
	docker push ${DOCKER_IMAGE}-alpine${ALPINE_VERSION}

latest: build
	docker tag ${DOCKER_IMAGE} ${DOCKER_REPO}:latest
	docker push ${DOCKER_REPO}:latest