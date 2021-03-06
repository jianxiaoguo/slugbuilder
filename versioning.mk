MUTABLE_VERSION ?= canary
VERSION ?= git-$(shell git rev-parse --short HEAD)
DOCKER_BUILD_FLAGS ?= --pull

IMAGE := ${DRYCC_REGISTRY}${IMAGE_PREFIX}/${SHORT_NAME}:${VERSION}.${STACK}
MUTABLE_IMAGE := ${DRYCC_REGISTRY}${IMAGE_PREFIX}/${SHORT_NAME}:${MUTABLE_VERSION}.${STACK}

info:
	@echo "Build tag:       ${VERSION}"
	@echo "Registry:        ${DRYCC_REGISTRY}"
	@echo "Immutable tag:   ${IMAGE}"
	@echo "Mutable tag:     ${MUTABLE_IMAGE}"

.PHONY: docker-push
docker-push: docker-immutable-push docker-mutable-push

.PHONY: docker-immutable-push
docker-immutable-push:
	docker push ${IMAGE}

.PHONY: docker-mutable-push
docker-mutable-push:
	docker push ${MUTABLE_IMAGE}
