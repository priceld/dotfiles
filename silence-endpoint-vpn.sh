ENDPOINT_RESOURCE_DIR="/Library/Application Support/Checkpoint/Endpoint Security/Endpoint Connect/Endpoint Security VPN.app/Contents/Resources"

# Ask for admin privelges
sudo -v

# Rename the sound files so they cannot be played.
sudo mv "$ENDPOINT_RESOURCE_DIR/TracConnected.wav" "$ENDPOINT_RESOURCE_DIR/TracConnected.wav.old"
sudo mv "$ENDPOINT_RESOURCE_DIR/TracFailed.wav" "$ENDPOINT_RESOURCE_DIR/TracFailed.wav.old"