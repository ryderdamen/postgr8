CURRENT_DATE = $(shell date +%Y-%m-%d-%H-%M-%S )

.PHONY: deploy
deploy:
	@kubectl apply -f kubernetes/secret.yaml \
		-f kubernetes/pvc.yaml \
		-f kubernetes/deployment.yaml \
		-f kubernetes/service.yaml \
		-f kubernetes/cronjob.yaml

.PHONY: backup
backup:
	@kubectl create job --from=cronjob/backup-postgres-example manually-triggered-backup-$(CURRENT_DATE)

.PHONY: restore
restore:
	@kubectl apply -f kubernetes/restore.yaml

.PHONY: node-pool-with-proper-scope
node-pool-with-proper-scope:
	@gcloud container node-pools create gcs-write-pool \
		--scopes=https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_write


.PHONY: build-push-all
build-push-all:
	@echo "Building & Pushing All Containers"; \
	cd containers/postgres_backup && make build && make push; \
	cd ../postgres_restore && make build && make push; \
	cd ../..
