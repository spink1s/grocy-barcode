#!/usr/bin/env bash
# Package the Grocy integration for HACS release
#
# This script creates a zip file suitable for HACS distribution.
# The zip file will be named according to hacs.json configuration.

set -e

# Change to the repository root
cd "$(dirname "$0")/.."

# Define output filename (from hacs.json)
OUTPUT_FILE="grocy.zip"

# Remove old package if it exists
if [ -f "$OUTPUT_FILE" ]; then
    echo "Removing existing $OUTPUT_FILE..."
    rm "$OUTPUT_FILE"
fi

echo "Creating HACS release package..."

# Create the zip file from within the grocy directory
# This ensures the zip contains just the files, not a folder
cd custom_components/grocy
zip -r "../../$OUTPUT_FILE" . \
    -x "*.pyc" \
    -x "*__pycache__*" \
    -x "*phil_services*" \
    -x "*.git*" \
    -x "*.DS_Store"
cd ../..

echo ""
echo "✓ Package created successfully!"
echo "  File: $OUTPUT_FILE"
echo "  Size: $(du -h "$OUTPUT_FILE" | cut -f1)"
echo ""
echo "Ready to upload to GitHub releases!"

