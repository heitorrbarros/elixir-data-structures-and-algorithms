DEV_CONTAINER=elixir-data-structure-algorithms-dev

build-dev-container:
	@docker build -t $(DEV_CONTAINER) -f Dockerfile .

attach-dev-container: build-dev-container
	@docker run -it --user 1001:1001 --rm -v $(PWD):/home/app $(DEV_CONTAINER) sh