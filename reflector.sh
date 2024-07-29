#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <program_name>"
    exit 1
fi

PROGRAM_NAME=$1
PROGRAM_PATH=$(which "$PROGRAM_NAME")

# Check if program exists
if [ ! -f "$PROGRAM_PATH" ]; then
    echo "Error: Program '$PROGRAM_NAME' not found."
    exit 1
fi

# Define directory for logs
LOG_DIR="${HOME}/reflectorlogs"
mkdir -p "$LOG_DIR"

# Define name of backup binary and new script
BACKUP_BINARY="${PROGRAM_PATH}_bin"
WRAPPER_SCRIPT="${PROGRAM_PATH}"

# Rename original binary to a backup
sudo cp "$PROGRAM_PATH" "$BACKUP_BINARY"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create a backup of '$PROGRAM_NAME'."
    exit 1
fi

# Create the new wrapper script using sudo bash -c
sudo bash -c "cat << 'EOL' > \"$WRAPPER_SCRIPT\"
#!/bin/bash

# log file location
LOG_FILE=\"$LOG_DIR/${PROGRAM_NAME}_log.txt\"
CWD=\$(pwd)
mkdir -p \"\$(dirname \"\$LOG_FILE\")\"

# date, command, current directory, and arguments
echo \"\$(date '+%Y-%m-%d %H:%M:%S') - \$CWD\" >> \"\$LOG_FILE\"
echo \"arguments: \$@\" >> \"\$LOG_FILE\"
echo \" \" >> \"\$LOG_FILE\"

# original executable with arguments
exec \"$BACKUP_BINARY\" \"\$@\"
EOL"

sudo chmod +x "$WRAPPER_SCRIPT"
echo "Reflector setup complete for '$PROGRAM_NAME'."
