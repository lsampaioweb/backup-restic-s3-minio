#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./init.sh local <repository>
# ./init.sh minio <repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

init() {
  logInfo "Initializing the backup of $1."

  $restic_path --repo "$1" init --password-command="$passwordCommand"

  logInfo "Initializing finished."
}

init $repository
