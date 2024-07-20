#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./forget.sh local <repository>
# ./forget.sh minio <repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

forget() {
  logInfo "Starting the clean up of $1."

  $restic_path --repo "$1" forget --keep-monthly $keep_monthly --keep-weekly $keep_weekly --keep-daily $keep_daily --keep-hourly $keep_hourly --password-command="$passwordCommand"

  $restic_path --repo "$1" prune --password-command="$passwordCommand"

  logInfo "Clean up finished."
}

forget $repository
