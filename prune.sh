#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./prune.sh local <repository>
# ./prune.sh minio <repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

check() {
  logInfo "Starting the pruning of $1."

  $restic_path --repo "$1" prune --password-command="$passwordCommand"

  logInfo "Pruning finished."
}

check $repository
