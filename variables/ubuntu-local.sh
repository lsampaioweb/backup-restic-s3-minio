#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$0")/variables/ubuntu.sh

# The password of the repository.
passwordCommand="secret-tool lookup secret 'restic-backup-local-password'"
