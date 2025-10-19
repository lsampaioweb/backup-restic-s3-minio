#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restore.sh local <repository> [snapshotId] [target]
# ./restore.sh minio <repository> [snapshotId] [target]

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

# The id of the snapshot.
snapshotId=${3:-"latest"}

# The directory where Restic will put the restored files.
target=${4:-"/tmp/$USER/backup"}

restore() {
  logInfo "Starting the restore of $1 at $3."

  $restic_path --repo "$1" restore "$2" --target "$3" --password-command="$passwordCommand" --verbose

  logInfo "Restore finished."
}

restore $repository $snapshotId $target
