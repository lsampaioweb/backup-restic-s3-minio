#!/bin/bash
set -e # Abort if there is an issue with any build.

# The address of the Bucket.
repository="/Volumes/Backup-03/MacOS-Backup-Luciano"

# The password of the repository.
passwordCommand="/usr/bin/security find-generic-password -a $USER -s 'restic-backup-macos-local' -w"
