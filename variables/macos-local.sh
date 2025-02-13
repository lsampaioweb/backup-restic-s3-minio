#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$0")/variables/macos.sh

# The password of the repository.
passwordCommand="/usr/bin/security find-generic-password -a $USER -s 'restic-backup-local-password' -w"
