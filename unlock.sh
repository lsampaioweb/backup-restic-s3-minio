#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./unlock.sh
# ./unlock.sh local
# ./unlock.sh minio

# Load the file with the common variables.
. $(dirname "$0")/variables/main.sh

check() {
  echo "Starting the unlock of $1"

  $restic_path --repo "$1" unlock --password-command="$passwordCommand"

  echo -e
}

check $repository
