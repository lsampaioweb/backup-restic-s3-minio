#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restic-backup.sh local <repository> [machine-name]
# ./restic-backup.sh minio <repository> [machine-name]

$(dirname "$0")/./backup.sh "$1" "$2" "$3"
$(dirname "$0")/./forget.sh "$1" "$2" "$3"
$(dirname "$0")/./prune.sh "$1" "$2" "$3"
$(dirname "$0")/./check.sh "$1" "$2" "$3"
