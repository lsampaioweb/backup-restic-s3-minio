#!/bin/bash
set -e # Abort if there is an issue with any build.

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  PID=$(pgrep -u $(id -u $USER) bash | head -n 1)
  DBUS="$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ | tr '\0' '\n' | sed -e 's/DBUS_SESSION_BUS_ADDRESS=//')"
  export DBUS_SESSION_BUS_ADDRESS=$DBUS
fi

# The path of the repository.
repository="/media/luciano.souza/Luciano/Backup"

# The path where the Restic application is installed.
restic_path="/usr/bin/restic"

# The password of the repository.
passwordCommand="secret-tool lookup password 'restic-password'"
