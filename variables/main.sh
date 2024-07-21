#!/bin/bash
set -e # Abort if there is an issue with any build.

# If true, more information will be printed in the output.
DEBUG=false

# The number of CPU cores to use. The default is "all".
export GOMAXPROCS=2

# The file that contains the folders to include in the backup.
files_from=$(dirname "$0")/files/includes.txt

# The file that contains the folders to exclude from the backup.
exclude_file=$(dirname "$0")/files/excludes.txt

# Get the current running OS.
operating_system=$(uname -o)

# The type of the backup (local or minio).
repository_type=$1

# The Restic repository.
# local: "/Volumes/Backup-03/MacOS-Backup-Luciano"
# minio: "s3:https://api.edge-minio-01.lan.homelab/macbook-luciano"
repository=$2

# The last n months which have one or more snapshots, keep only the most recent one for each month.
keep_monthly=24

# The last n weeks which have one or more snapshots, keep only the most recent one for each week.
keep_weekly=4

# The last n days which have one or more snapshots, keep only the most recent one for each day.
keep_daily=30

# The last n hours which have one or more snapshots, keep only the most recent one for each hour.
keep_hourly=24

# Variables with specific content for MacOS or Ubuntu.
if [ $operating_system == "Darwin" ]; then
  . $(dirname "$0")/variables/macos-$repository_type.sh

elif [ $operating_system == "GNU/Linux" ]; then
  . $(dirname "$0")/variables/ubuntu-$repository_type.sh

fi
