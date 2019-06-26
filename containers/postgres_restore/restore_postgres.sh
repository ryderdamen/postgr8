# Script for restoring a snapshot of a postgres database

# Check to make sure all required variables exist
[ -z "$GCS_POSTGRES_SNAPSHOT" ] && echo "GCS_POSTGRES_SNAPSHOT Not Set" && exit 1
[ -z "$POSTGRES_DATABASE_NAME" ] && echo "POSTGRES_DATABASE_NAME Not Set" && exit 1
[ -z "$POSTGRES_USERNAME" ] && echo "POSTGRES_USERNAME Not Set" && exit 1
[ -z "$PGPASSWORD" ] && echo "PGPASSWORD Not Set" && exit 1
[ -z "$PGHOST" ] && echo "PGHOST Not Set" && exit 1
[ ! -f /var/secrets/google/gcp_service_account.json ] && echo "GCS Service Account Does Not Exist" && exit 1


# Check to make sure backup exists in Google Cloud Storage
if [ ! gsutil stat $GCS_POSTGRES_SNAPSHOT ]; then echo "Snapshot Does Not Exist" && exit 1; fi;


# Set Local Variables
export POSTGRES_RESTORE_PATH=/code/downloaded_restore.sql


# Download the snapshot from GCS and restore it into the running DB (in another pod)
gsutil -m cp $GCS_POSTGRES_SNAPSHOT $POSTGRES_RESTORE_PATH && \
    pg_restore -w -U $POSTGRES_USERNAME -d $POSTGRES_DATABASE_NAME -v "$POSTGRES_RESTORE_PATH"
