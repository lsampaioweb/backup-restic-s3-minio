#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./forget.sh
# ./forget.sh local
# ./forget.sh minio

# Load the file with the common variables.
. $(dirname "$0")/variables/main.sh

forget() {
  echo "Starting the clean up of $1"

  $restic_path --repo "$1" forget --keep-monthly $keep_monthly --keep-weekly $keep_weekly --keep-daily $keep_daily --keep-hourly $keep_hourly --password-command="$passwordCommand"

  $restic_path --repo "$1" prune --password-command="$passwordCommand"

  echo -e
}

forget $repository
