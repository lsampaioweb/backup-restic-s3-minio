#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./check.sh

# Load the file with the common variables.
. $(dirname "$0")/variables.sh

check() {
  echo "Starting the check of integrity of $1"

  restic --repo "$1" check --password-command="$passwordCommand"

  echo -e
}

check $repository
