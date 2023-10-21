#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./restic-backup.sh

./backup.sh
./forget.sh
./check.sh
