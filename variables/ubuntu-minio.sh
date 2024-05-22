#!/bin/bash
set -e # Abort if there is an issue with any build.

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  PID=$(pgrep -u $(id -u $USER) bash | head -n 1)
  DBUS="$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ | tr '\0' '\n' | sed -e 's/DBUS_SESSION_BUS_ADDRESS=//')"
  export DBUS_SESSION_BUS_ADDRESS=$DBUS
fi

# Variables with the same content for MacOS and Ubuntu.
# The URL of MinIO.
minio_url="s3:https://api.edge-minio-01.homelab/"

# The name of the Bucket.
bucket_name="ubuntu-desktop"

# The address of the Bucket.
repository="${minio_url}${bucket_name}"

# The path where the Restic application is installed.
restic_path="/usr/local/bin/restic"

# The password of the repository.
passwordCommand="secret-tool lookup password 'edge-minio-01-restic-backup'"

# The "ID" that Restic will use to connect to MinIO.
export AWS_ACCESS_KEY_ID="$(secret-tool lookup password 'edge-minio-01-restic-backup-access-key-id')"

# The "Password" that Restic will use to connect to MinIO.
export AWS_SECRET_ACCESS_KEY="$(secret-tool lookup password 'edge-minio-01-restic-backup-secret-access-key')"
