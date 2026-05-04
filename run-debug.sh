#!/usr/bin/env bash
# Build & install debug APK on connected Android device, passing API keys from
# android/gemini.properties (git-ignored). Run from repo root: ./run-debug.sh

set -e

PROPS="android/gemini.properties"
if [ ! -f "$PROPS" ]; then
  echo "Missing $PROPS. Create it with: GEMINI_API_KEY=... and REMOVE_BG_API_KEY=..."
  exit 1
fi

GEMINI_KEY="$(grep '^GEMINI_API_KEY=' "$PROPS" | cut -d'=' -f2- | tr -d '[:space:]')"
REMOVEBG_KEY="$(grep '^REMOVE_BG_API_KEY=' "$PROPS" | cut -d'=' -f2- | tr -d '[:space:]')"

ADB="/c/Users/UTENTE/AppData/Local/Android/Sdk/platform-tools/adb.exe"
DEVICE="$(${ADB} devices | awk 'NR==2 {print $1}')"

DEFINES=()
[ -n "$GEMINI_KEY" ] && DEFINES+=(--dart-define=GEMINI_API_KEY="$GEMINI_KEY")
[ -n "$REMOVEBG_KEY" ] && DEFINES+=(--dart-define=REMOVE_BG_API_KEY="$REMOVEBG_KEY")

if [ -z "$DEVICE" ]; then
  echo "No device connected. Building APK only."
  flutter build apk --debug "${DEFINES[@]}"
  echo "APK at: build/app/outputs/flutter-apk/app-debug.apk"
  exit 0
fi

echo "==> Building debug APK (device: $DEVICE)"
flutter build apk --debug "${DEFINES[@]}"

echo "==> Installing on device"
"$ADB" -s "$DEVICE" install -r build/app/outputs/flutter-apk/app-debug.apk

echo "==> Launching app"
"$ADB" -s "$DEVICE" shell am start -n com.whatskit.whatskit/.MainActivity

echo "Done."
