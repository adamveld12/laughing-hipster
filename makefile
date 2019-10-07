.PHONY: build build-test deb-test dev

./tools:
	git submodule init && git submodule update

build: ./tools
	docker build -t adamveld12/dotfiles:latest -f ./Dockerfile .

build-test: ./tools
	docker build -t adamveld12/dotfiles:deb-test -f ./Dockerfile.debian .

deb-test:
	docker run -it --rm --name dotfiles \
		-u $${USER_ID:-1000} \
		-v $$PWD:/home/dotfiles/Projects/dotfiles:ro \
		--workdir /home/dotfiles/Projects/dotfiles \
		adamveld12/dotfiles:deb-test


dev:
	docker run -it --rm --name dotfiles \
		-u $${USER_ID:-1000} \
		-v $$PWD:/home/dev/Projects/dotfiles:ro \
		--workdir /home/dev/Projects/dotfiles \
		adamveld12/dotfiles:latest

