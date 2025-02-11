#!/bin/bash
set -e # Abort if there is an issue with any build.

# If true, more information will be printed in the output.
DEBUG=false

# The number of CPU cores to use. The default is "all".
export GOMAXPROCS=1

# The type of the backup (local or minio).
repository_type=$1

# The Restic repository for MacOs.
# local: "/Volumes/Backup-03/MacOS-Backup-Luciano"
# minio: "s3:https://api.edge-minio-01.lan.homelab/macbook-luciano"

# The Restic repository for Ubuntu.
# local: "/media/luciano.souza/Luciano/Backup"
# minio: "s3:https://api.storage.lan.homelab/ubuntu-desktop"
repository=$2

# The last n months which have one or more snapshots, keep only the most recent one for each month.
keep_monthly=24

# The last n weeks which have one or more snapshots, keep only the most recent one for each week.
keep_weekly=4

# The last n days which have one or more snapshots, keep only the most recent one for each day.
keep_daily=30

# The last n hours which have one or more snapshots, keep only the most recent one for each hour.
keep_hourly=24

# Get the current running OS type.
operating_system_type=$(uname -o)

# Get the current running OS.
operating_system=""

# Variables with specific content for MacOS or Ubuntu.
if [ $operating_system_type == "Darwin" ]; then
  operating_system="macos"

elif [ $operating_system_type == "GNU/Linux" ]; then
  operating_system="ubuntu"

fi

# The file that contains the folders to include in the backup.
files_from=$(dirname "$0")/files/${operating_system}/includes.txt

# The file that contains the folders to exclude from the backup.
exclude_file=$(dirname "$0")/files/${operating_system}/excludes.txt

# Load the variables based on the operating system.
. $(dirname "$0")/variables/${operating_system}-$repository_type.sh
