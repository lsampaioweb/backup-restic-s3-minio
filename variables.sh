#!/bin/bash
set -e # Abort if there is an issue with any build.

# Variables with the same content for MacOS and Ubuntu.
# The URL of MinIO.
minio_url="s3:https://api.edge-minio-01.homelab/"

# The name of the Bucket.
bucket_name="macbook-luciano"

# The address of the Bucket.
repository="$minio_url$bucket_name"

# The number of CPU cores to use. The default is "all".
export GOMAXPROCS=1

# The file that contains the folders to include in the backup.
files_from=$(dirname "$0")/Files/includes.txt

# The file that contains the folders to exclude from the backup.
exclude_file=$(dirname "$0")/Files/excludes.txt

# Get the current running OS.
operating_system=$(uname -o)

# Variables with specific content for MacOS or Ubuntu.
if [ $operating_system == "Darwin" ]; then
  . $(dirname "$0")/MacOS/variables.sh

elif [ $operating_system == "GNU/Linux" ]; then
  . $(dirname "$0")/Ubuntu/variables.sh

fi
