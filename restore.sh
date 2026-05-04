#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restore.sh local <repository> [machine-name] [snapshotId] [target]
# ./restore.sh minio <repository> [machine-name] [snapshotId] [target]

# machine-name is $3 (consistent with all other scripts).
export BACKUP_MACHINE_NAME="${3-}"

# Load the file with the common variables.
. $(dirname "$0")/lib/log.sh
. $(dirname "$0")/variables/main.sh

# The id of the snapshot.
snapshotId=${4:-"latest"}

# The directory where Restic will put the restored files.
target=${5:-"/tmp/$USER/backup"}

restore() {
  logInfo "Starting the restore of $1 at $3."

  $restic_path --repo "$1" restore "$2" --target "$3" --password-command="$passwordCommand" --verbose

  logInfo "Restore finished."
}

restore $repository $snapshotId $target
