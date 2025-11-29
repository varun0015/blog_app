#!/usr/bin/env bash
# Small helper to create a placeholder app icon (1x1 transparent PNG) by decoding base64.
# Replace the base64 string with your own image's base64 if desired.
set -e
mkdir -p "$(dirname "$0")/../assets/icons"
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ICON_PATH="$BASE_DIR/assets/icons/app_icon.png"
cat > "$ICON_PATH" <<'BASE64PNG'
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=
BASE64PNG
# Decode
if base64 --help >/dev/null 2>&1; then
	base64 --decode -i "$ICON_PATH" -o "$ICON_PATH.decoded"
else
	# macOS / BSD base64 uses -D to decode
	base64 -D -i "$ICON_PATH" -o "$ICON_PATH.decoded"
fi
mv "$ICON_PATH.decoded" "$ICON_PATH"
chmod 644 "$ICON_PATH"

echo "Placeholder icon created at: $ICON_PATH"
echo "Replace with a 1024x1024 PNG and run 'flutter pub run flutter_launcher_icons:main' to generate platform icons."
