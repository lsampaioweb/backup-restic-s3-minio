#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./backup.sh
# ./backup.sh local
# ./backup.sh minio

# Load the file with the common variables.
. $(dirname "$0")/variables/main.sh

backup() {
  echo "Starting the backup of $1"

  $restic_path --repo "$1" backup --verbose --tag "$2" --files-from="$files_from" --exclude-file="$exclude_file" --password-command="$passwordCommand"

  echo -e
}

backup $repository "$(date +%B)"
