#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$0")/variables/ubuntu.sh

# The password of the repository.
passwordCommand="secret-tool lookup password 'restic-backup-password'"

# The "ID" that Restic will use to connect to MinIO.
export AWS_ACCESS_KEY_ID="$(secret-tool lookup password 'restic-backup-access-key-id')"

# The "Password" that Restic will use to connect to MinIO.
export AWS_SECRET_ACCESS_KEY="$(secret-tool lookup password 'restic-backup-secret-access-key')"
