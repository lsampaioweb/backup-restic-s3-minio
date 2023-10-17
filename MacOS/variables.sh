#!/bin/bash
set -e # Abort if there is an issue with any build.

# The address of the Bucket.
repository="s3:https://api.edge-minio-01.homelab/macbook-luciano"

# The password of the repository.
passwordCommand="security find-generic-password -s "edge-minio-01-restic-backup" -w"

# The "ID" that Restic will use to connect to MinIO.
export AWS_ACCESS_KEY_ID="$(security find-generic-password -s "edge-minio-01-restic-backup-access-key-id" -w)"

# The "Password" that Restic will use to connect to MinIO.
export AWS_SECRET_ACCESS_KEY="$(security find-generic-password -s "edge-minio-01-restic-backup-secret-access-key" -w)"
