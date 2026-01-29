#!/bin/bash

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy automator workflows to Services directory
cp -R "$SCRIPT_DIR/automator/"*.workflow ~/Library/Services/

echo "Automator scripts installed successfully!"
echo "Note: You may need to restart Finder to pick up the changes:"
echo "  killall Finder"
