#!/usr/bin/env bash
# Generate platform icons using flutter_launcher_icons with a backup of current icons
set -e
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKUP_DIR="$ROOT_DIR/assets/icons/backup_$(date +%s)"
mkdir -p "$BACKUP_DIR/android"
mkdir -p "$BACKUP_DIR/ios"

# Backup Android mipmap ic_launcher files
echo "Backing up Android icons..."
for d in "$ROOT_DIR/android/app/src/main/res/mipmap-"*; do
  if [ -d "$d" ]; then
    cp "$d"/ic_launcher* "$BACKUP_DIR/android/" 2>/dev/null || true
  fi
done

# Backup iOS AppIcon.appiconset
if [ -d "$ROOT_DIR/ios/Runner/Assets.xcassets/AppIcon.appiconset" ]; then
  echo "Backing up iOS AppIcon.appiconset..."
  cp -R "$ROOT_DIR/ios/Runner/Assets.xcassets/AppIcon.appiconset" "$BACKUP_DIR/ios/" || true
fi

# Run flutter_launcher_icons generator
cd "$ROOT_DIR"
flutter pub get
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
  echo "Icons generated. Backups are at: $BACKUP_DIR"
else
  echo "Icon generation failed. Check the output above." >&2
  exit 1
fi
