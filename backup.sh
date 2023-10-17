#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./backup.sh

# Load the file with the common variables.
. $(dirname "$0")/variables.sh

backup() {
  echo "Starting the backup of $1"

  restic --repo "$1" backup --verbose --tag "$2" --files-from="Files/includes.txt" --exclude-file="Files/excludes.txt" --password-command="$passwordCommand"

  echo -e
}

backup $repository "$(date +%B)"
