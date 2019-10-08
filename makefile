.PHONY: build build-test deb-test dev

./tools:
	git submodule init && git submodule update

build: ./tools
	docker build -t vdhsn/dotfiles:$${VERSION:-latest} \
		--build-arg version=$${VERSION} \
		--build-arg commit=$${COMMIT_SHA:-$${CIRCLE_SHA1}} \
		--build-arg initiator=$${INITIATOR:-$${CIRCLE_USERNAME}} \
		--build-arg created=$${CREATED_TS:-$$(date +%s)} \
		-f ./Dockerfile .


publish: build
	docker push vdhsn/dotfiles:$${VERSION}

build-test: ./tools
	docker build -t vdhsn/dotfiles:deb-test -f ./Dockerfile.debian .

deb-test:
	docker run -it --rm --name dotfiles \
		-u $${USER_ID:-1000} \
		-v $$PWD:/home/dotfiles/Projects/dotfiles:ro \
		--workdir /home/dotfiles/Projects/dotfiles \
		vdhsn/dotfiles:deb-test


dev:
	docker run -it --rm --name dotfiles \
		-u $${USER_ID:-1000} \
		-v $$PWD:/home/dev/Projects/dotfiles:ro \
		--workdir /home/dev/Projects/dotfiles \
		vdhsn/dotfiles:$${VERSION:-latest}

