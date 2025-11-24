#!/bin/bash

# Setup secrets for manual editing

SECRETS_FILE="modules/shared/secrets.nix"
EXAMPLE_FILE="modules/shared/secrets.nix.example"

if [ -f "$SECRETS_FILE" ]; then
    echo "$SECRETS_FILE already exists."
else
    echo "Copying $EXAMPLE_FILE to $SECRETS_FILE..."
    cp "$EXAMPLE_FILE" "$SECRETS_FILE"
    echo "Done."
fi

echo "----------------------------------------------------------------"
echo "Setup complete!"
echo ""
echo "ACTION REQUIRED:"
echo "1. Open $SECRETS_FILE"
echo "2. Read the comments for instructions on where to find each value."
echo "3. Replace the placeholder values with your actual secrets."
echo "----------------------------------------------------------------"
