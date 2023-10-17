#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
# ./daily.sh

./backup.sh
./forget.sh
./check.sh
