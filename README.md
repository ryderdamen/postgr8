# Postgr8 - PostgreSQL in Kubernetes
Postgr8 is an example of a postgreSQL instance running in kubernetes with an autonomous backup system to Google Cloud Storage.

## How It Works
Quite simply, postgr8 runs a sole-replica deployment of the postgres:11 docker image in your kubernetes cluster with a service sitting in front of it to route traffic. The postgres data directory writes to a volume mounted with the persistent volume claim, meaning if the pod is killed for whatever reason - your data survives.

If somehow, you manage to delete the persistent volume claim, there's still a nightly cron backup which occurs via a cron job within the cluster. This backup connects to your running postgres image and uses the pg_dump and gcloud commands to dump and upload the database to a Google Cloud Storage (GCS) bucket of your choosing.

## Repository Structure
- containers
    - Contains dockerfiles and generic scripts for backup and restoration images
    - These images have been designed so that they are fully configurable with environment variables in your yaml manifests
    - They can also be pulled directly from ryderdamen/postgres-backup and ryderdamen/postgres-restore respectively.
- kubernetes
    - Contains example manifests for deploying an example postgres database (with full backups and statefullness) to your kubernetes cluster.

## What's the purpose
This repository is designed to be used as a referrence for how to deploy a postgres database within a kubernetes cluster. As always, using managed services is always an easier route - but if you're looking to save a bit of money for a small project - running postgres within your cluster can be a great way to do it.
