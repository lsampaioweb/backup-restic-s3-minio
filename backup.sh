#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./backup.sh local <repository>
# ./backup.sh minio <repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

backup() {
  logInfo "Starting the backup of $1."

  # Use full power of the machine.
  $restic_path --repo "$1" backup --tag "$2" --files-from="$files_from" --exclude-file="$exclude_file" --password-command="$passwordCommand" --verbose

  # Use this command if you have a cheap or old disk to reduce I/O stress.
  # $restic_path --repo "$1" backup --tag "$2" --files-from="$files_from" --exclude-file="$exclude_file" --password-command="$passwordCommand" --verbose --limit-upload 5000 -o s3.connections=2

  logInfo "Backup finished."
}

backup $repository "$(date +%B)"
