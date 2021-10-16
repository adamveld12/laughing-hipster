.PHONY: dev
dev:
	@docker run -it --rm --name files \
				-v $$PWD:/home/files/.files:ro \
				adamveld12/files
.PHONY: build
build:
	@docker build -t adamveld12/files .
