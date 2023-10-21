#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restic-backup.sh

$(dirname "$0")/./backup.sh
$(dirname "$0")/./forget.sh
$(dirname "$0")/./check.sh
