#!/bin/bash
set -e # Abort if there is an issue with any build.

. $(dirname "$0")/variables/ubuntu.sh

# The path of the repository.
repository="/media/luciano.souza/Luciano/Backup"

# The password of the repository.
passwordCommand="secret-tool lookup password 'restic-password'"
