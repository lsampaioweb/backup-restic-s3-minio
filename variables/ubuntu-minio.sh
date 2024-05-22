#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$0")/variables/ubuntu.sh

# Variables with the same content for MacOS and Ubuntu.
# The URL of MinIO.
minio_url="s3:https://api.edge-minio-01.homelab/"

# The name of the Bucket.
bucket_name="ubuntu-desktop"

# The address of the Bucket.
repository="${minio_url}${bucket_name}"

# The password of the repository.
passwordCommand="secret-tool lookup password 'edge-minio-01-restic-backup'"

# The "ID" that Restic will use to connect to MinIO.
export AWS_ACCESS_KEY_ID="$(secret-tool lookup password 'edge-minio-01-restic-backup-access-key-id')"

# The "Password" that Restic will use to connect to MinIO.
export AWS_SECRET_ACCESS_KEY="$(secret-tool lookup password 'edge-minio-01-restic-backup-secret-access-key')"
