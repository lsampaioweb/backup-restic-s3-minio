#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./snapshots.sh
# ./snapshots.sh local
# ./snapshots.sh minio

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

check() {
  logInfo "Listing snapshots of $1."

  $restic_path --repo "$1" snapshots --password-command="$passwordCommand"

  logInfo "Listing snapshots finished."
}

check $repository
