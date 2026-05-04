#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./copy.sh local <destination-repository> [machine-name] <source-repository>
# ./copy.sh minio <destination-repository> [machine-name] <source-repository>

# machine-name is $3 (consistent with all other scripts).
export BACKUP_MACHINE_NAME="${3-}"

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

# The source repository to copy snapshots from.
sourceRepository="$4"

copy() {
  logInfo "Starting the copy of $2 to $1."

  # Use full power of the machine.
  $restic_path --repo "$1" copy --from-repo "$2" --password-command="$passwordCommand" --verbose

  # Use this command if you have a cheap or old disk to reduce I/O stress.
  # $restic_path --repo "$1" copy --from-repo "$2" --password-command="$passwordCommand" --verbose --limit-upload 5000 -o s3.connections=2

  logInfo "Copy finished."
}

copy $repository $sourceRepository
