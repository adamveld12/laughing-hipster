PLATFORM ?= linux/amd64
IMAGE ?= localhost/adamveld12/files
PUBLISH_IMAGE ?= docker.io/adamveld12/files

.PHONY: dev
dev:
	@podman run --platform $(PLATFORM) -it --rm --name files \
				-v $$PWD:/home/files/.files:ro \
				$(IMAGE)
.PHONY: build
build:
	@podman build --platform $(PLATFORM) -t $(IMAGE) .

SHA:=$(shell git rev-parse --short=6 HEAD)

.PHONY: publish
publish:
	podman build --platform $(PLATFORM) -t $(PUBLISH_IMAGE):latest -t $(PUBLISH_IMAGE):$(SHA) .
	podman push $(PUBLISH_IMAGE):$(SHA)
	podman push $(PUBLISH_IMAGE):latest
