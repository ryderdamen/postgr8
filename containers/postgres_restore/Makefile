IMAGE_NAME=gcr.io/your-google-cloud-project-id/postgres-restore
VERSION=0.0.1

.PHONY: build
build:
	@docker build -t $(IMAGE_NAME):$(VERSION) .

.PHONY: push
push:
	@docker push $(IMAGE_NAME):$(VERSION)

.PHONY: run
run:
	@docker run $(IMAGE_NAME):$(VERSION)
