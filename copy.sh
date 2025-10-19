#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./copy.sh local <destination-repository> <source-repository>
# ./copy.sh minio <destination-repository> <source-repository>

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

# The id of the snapshot.
sourceRepository="$3"

copy() {
  logInfo "Starting the copy of $2 to $1."

  # Use full power of the machine.
  $restic_path --repo "$1" copy --from-repo "$2" --password-command="$passwordCommand" --verbose

  # Use this command if you have a cheap or old disk to reduce I/O stress.
  # $restic_path --repo "$1" copy --from-repo "$2" --password-command="$passwordCommand" --verbose --limit-upload 5000 -o s3.connections=2

  logInfo "Copy finished."
}

copy $repository $sourceRepository
