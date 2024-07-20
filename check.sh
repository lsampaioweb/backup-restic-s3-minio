#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./check.sh local <repository>
# ./check.sh minio <repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

check() {
  logInfo "Starting the check of integrity of $1."

  $restic_path --repo "$1" check --password-command="$passwordCommand"

  logInfo "Check finished."
}

check $repository
