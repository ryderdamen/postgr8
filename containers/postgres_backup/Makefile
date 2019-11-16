IMAGE_NAME=ryderdamen/postgres-backup
VERSION=11

.PHONY: build
build:
	@docker build -t $(IMAGE_NAME):$(VERSION) .

.PHONY: push
push:
	@docker push $(IMAGE_NAME):$(VERSION)

.PHONY: run
run:
	@docker run $(IMAGE_NAME):$(VERSION)
