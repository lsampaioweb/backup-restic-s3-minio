#!/bin/bash

getCurrentDateTime() {
  date "+%Y-%m-%d %H:%M:%S"
}

logMessage () {
  echo $(getCurrentDateTime) $*
}

logDebug () {
  if [ "$DEBUG" == true ]; then
    logMessage "DEBUG:" $*
  fi
}

logInfo () {
  logMessage "INFO:" $*
}
