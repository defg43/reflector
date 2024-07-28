#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <program_name>"
    exit 1
fi

PROGRAM_NAME=$1
PROGRAM_PATH=$(which "$PROGRAM_NAME")

mv "${PROGRAM_PATH}_bin" "$PROGRAM_PATH"
echo "Stopped reflector for '$PROGRAM_NAME'."
