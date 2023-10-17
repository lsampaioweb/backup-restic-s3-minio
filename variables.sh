#!/bin/bash
set -e # Abort if there is an issue with any build.

operating_system=$(uname -o)

if [ $operating_system == "Darwin" ]; then
  . $(dirname "$0")/MacOS/variables.sh

elif [ $operating_system == "GNU/Linux" ]; then
  . $(dirname "$0")/Ubuntu/variables.sh

fi
