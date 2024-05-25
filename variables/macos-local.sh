#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$0")/variables/macos.sh

# The address of the Bucket.
repository="/Volumes/Backup-03/MacOS-Backup-Luciano"

# The password of the repository.
passwordCommand="/usr/bin/security find-generic-password -a $USER -s 'restic-backup-macos-local' -w"
