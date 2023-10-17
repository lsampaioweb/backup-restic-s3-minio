#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restore.sh

# Load the file with the common variables.
. $(dirname "$0")/variables.sh

# The id of the snapshot
snapshotId="latest"

# The directory where Restic will put the restored files.
target="/tmp/$USER/Backup"

restore() {
  echo "Starting the restore of $1 at $3"

  restic --repo "$1" --verbose restore "$2" --target "$3" --password-command="$passwordCommand"

  echo -e
}

restore $repository $snapshotId $target