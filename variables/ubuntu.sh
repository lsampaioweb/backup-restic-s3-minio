#!/bin/bash
set -e # Abort if there is an issue with any build.

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  PID=$(pgrep -u $(id -u $USER) bash | head -n 1)
  DBUS="$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ | tr '\0' '\n' | sed -e 's/DBUS_SESSION_BUS_ADDRESS=//')"
  export DBUS_SESSION_BUS_ADDRESS=$DBUS
fi
