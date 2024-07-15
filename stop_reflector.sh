#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <program_name>"
    exit 1
fi

PROGRAM_NAME=$1
PROGRAM_PATH=$(which "$PROGRAM_NAME")

# rm "$PROGRAM_NAME"
mv "${PROGRAM_NAME}_bin" "$PROGRAM_NAME"
# rm "${PROGRAM_NAME}_bin"

echo "Stopped reflector for '$PROGRAM_NAME'."
