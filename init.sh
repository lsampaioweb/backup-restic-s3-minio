#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./init.sh

# Load the file with the common variables.
. $(dirname "$0")/variables.sh

init() {
  echo "Initializing the backup of $1"

  restic --repo "$1" init --password-command="$passwordCommand"

  echo -e
}

init $repository
