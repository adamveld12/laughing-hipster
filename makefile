.PHONY: dev
dev:
	@docker run -it --rm --name files \
				-v $$PWD:/home/files/.files:ro \
				adamveld12/files
.PHONY: build
build:
	@docker build -t adamveld12/files .

SHA:=$(shell git rev-parse --short=6 HEAD)

.PHONY: publish
publish:
	docker build -t adamveld12/files:latest -t adamveld12/files:$(SHA) .
	docker push adamveld12/files:$(SHA)
	docker push adamveld12/files:latest
