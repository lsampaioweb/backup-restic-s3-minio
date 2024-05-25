#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restore.sh local [snapshotId] [target]
# ./restore.sh minio [snapshotId] [target]

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

# The id of the snapshot.
snapshotId=${2:-"latest"}

# The directory where Restic will put the restored files.
target=${3:-"/tmp/$USER/backup"}

restore() {
  logInfo "Starting the restore of $1 at $3."

  $restic_path --repo "$1" --verbose restore "$2" --target "$3" --password-command="$passwordCommand"

  logInfo "Restore finished."
}

restore $repository $snapshotId $target
