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

# Optional machine name used to resolve machine-specific include/exclude files.
machine_name=$3

# Optional machine name override for scripts where $3 has a different meaning.
# If BACKUP_MACHINE_NAME is defined (even empty), it takes precedence over $3.
if [ -n "${BACKUP_MACHINE_NAME+x}" ]; then
  machine_name="$BACKUP_MACHINE_NAME"
fi

# The last n months which have one or more snapshots, keep only the most recent one for each month.
keep_monthly=24

# The last n weeks which have one or more snapshots, keep only the most recent one for each week.
keep_weekly=4

# The last n days which have one or more snapshots, keep only the most recent one for each day.
keep_daily=30

# The last n hours which have one or more snapshots, keep only the most recent one for each hour.
keep_hourly=24

# Get the current running OS type.
operating_system_type=$(uname -s)

# Get the current running OS.
operating_system=""

# Variables with specific content for MacOS or Ubuntu.
if [ "$operating_system_type" == "Darwin" ]; then
  operating_system="macos"

elif [ "$operating_system_type" == "Linux" ]; then
  operating_system="ubuntu"

fi

if [ -z "$operating_system" ]; then
  echo "Unsupported operating system: $operating_system_type"
  exit 1
fi

# Use the machine name from arg3 when present. Otherwise fall back to hostname.
if [ -z "$machine_name" ]; then
  machine_name=$(hostname -s)
fi

machine_include_file=$(dirname "$0")/files/${operating_system}/${machine_name}/includes.txt
machine_exclude_file=$(dirname "$0")/files/${operating_system}/${machine_name}/excludes.txt

# The file that contains the folders to include in the backup.
files_from=$(dirname "$0")/files/${operating_system}/includes.txt

# The file that contains the folders to exclude from the backup.
exclude_file=$(dirname "$0")/files/${operating_system}/excludes.txt

# If both machine-specific files exist, use them.
if [ -f "$machine_include_file" ] && [ -f "$machine_exclude_file" ]; then
  files_from="$machine_include_file"
  exclude_file="$machine_exclude_file"
fi

# Load the variables based on the operating system.
. $(dirname "$0")/variables/${operating_system}-$repository_type.sh
