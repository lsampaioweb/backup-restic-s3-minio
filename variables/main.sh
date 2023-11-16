#!/bin/bash
set -e # Abort if there is an issue with any build.

# The number of CPU cores to use. The default is "all".
export GOMAXPROCS=1

# The file that contains the folders to include in the backup.
files_from=$(dirname "$0")/Files/includes.txt

# The file that contains the folders to exclude from the backup.
exclude_file=$(dirname "$0")/Files/excludes.txt

# Get the current running OS.
operating_system=$(uname -o)

# The type of the backup (local or minio). Default: minio
repository_type=${1:-"minio"}

# Variables with specific content for MacOS or Ubuntu.
if [ $operating_system == "Darwin" ]; then
  . $(dirname "$0")/variables/macos-$repository_type.sh

elif [ $operating_system == "GNU/Linux" ]; then
  . $(dirname "$0")/variables/ubuntu-$repository_type.sh

fi
