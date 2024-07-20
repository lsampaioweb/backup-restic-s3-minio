#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./unlock.sh local <repository>
# ./unlock.sh minio <repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

check() {
  logInfo "Starting the unlock of $1."

  $restic_path --repo "$1" unlock --password-command="$passwordCommand"

  logInfo "Unlock finished."
}

check $repository
