# Bash script for backing up remote postgres database to Google Cloud Storage


# Check to make sure all required variables exist
[ -z "$GCS_FULL_BUCKET_UPLOAD_PATH" ] && echo "GCS_FULL_BUCKET_UPLOAD_PATH Not Set" && exit 1
[ -z "$POSTGRES_DATABASE_NAME" ] && echo "POSTGRES_DATABASE_NAME Not Set" && exit 1
[ -z "$POSTGRES_USERNAME" ] && echo "POSTGRES_USERNAME Not Set" && exit 1
[ -z "$PGPASSWORD" ] && echo "PGPASSWORD Not Set" && exit 1
[ -z "$PGHOST" ] && echo "PGHOST Not Set" && exit 1
[ ! -f /var/secrets/google/gcp_service_account.json ] && echo "GCS Service Account Does Not Exist" && exit 1


# Generate export variables from current datetime
export BACKUP_DATETIME=`date '+%Y-%m-%d__%H-%M'`
export BACKUP_LOCAL_FILENAME=postgres_$POSTGRES_DATABASE_NAME_backup_$BACKUP_DATETIME.sql


# Dump the postgres database to a local file and upload to Google Cloud Storage
pg_dump -Fc -o -w -U $POSTGRES_USERNAME $POSTGRES_DATABASE_NAME > ./$BACKUP_LOCAL_FILENAME && \
    gsutil -m cp $BACKUP_LOCAL_FILENAME $GCS_FULL_BUCKET_UPLOAD_PATH
