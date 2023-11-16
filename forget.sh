#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./forget.sh

# Load the file with the common variables.
. $(dirname "$0")/variables/main.sh

forget() {
  echo "Starting the clean up of $1"

  $restic_path --repo "$1" forget --keep-monthly 12 --keep-weekly 5 --keep-daily 15 --keep-hourly 24 --password-command="$passwordCommand"
  $restic_path --repo "$1" prune --password-command="$passwordCommand"

  echo -e
}

forget $repository
