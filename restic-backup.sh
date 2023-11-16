#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restic-backup.sh

$(dirname "$0")/./backup.sh "$1"
$(dirname "$0")/./forget.sh "$1"
$(dirname "$0")/./check.sh "$1"
