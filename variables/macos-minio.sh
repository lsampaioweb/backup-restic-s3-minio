#!/bin/bash
set -e # Abort if there is an issue with any build.

# Variables with the same content for MacOS and Ubuntu.
# The URL of MinIO.
minio_url="s3:https://api.edge-minio-01.homelab/"

# The name of the Bucket.
bucket_name="macbook-luciano"

# The address of the Bucket.
repository="${minio_url}${bucket_name}"

# The password of the repository.
passwordCommand="/usr/bin/security find-generic-password -a $USER -s 'edge-minio-01-restic-backup' -w"

# The "ID" that Restic will use to connect to MinIO.
export AWS_ACCESS_KEY_ID="$(/usr/bin/security find-generic-password -a $USER -s 'edge-minio-01-restic-backup-access-key-id' -w)"

# The "Password" that Restic will use to connect to MinIO.
export AWS_SECRET_ACCESS_KEY="$(/usr/bin/security find-generic-password -a $USER -s 'edge-minio-01-restic-backup-secret-access-key' -w)"
