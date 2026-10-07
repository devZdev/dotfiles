#!/bin/bash
# Install the current tastytrade Desktop 2.0 app from tastytrade's official download.
set -euo pipefail

case "$(uname -m)" in
    arm64) mac_arch="arm64" ;;
    x86_64) mac_arch="x64" ;;
    *) echo "Unsupported Mac architecture for tastytrade Desktop 2.0." >&2; exit 1 ;;
esac

temp_dir=$(mktemp -d "${TMPDIR:-/tmp}/tastytrade-desktop-2.XXXXXX")
mount_dir="$temp_dir/mount"
mkdir "$mount_dir"
mounted=0

cleanup() {
    if [ "$mounted" -eq 1 ]; then
        hdiutil detach -quiet "$mount_dir" || true
    fi
    rm -f "$temp_dir/installer.dmg"
    rmdir "$mount_dir" "$temp_dir" 2>/dev/null || true
}
trap cleanup EXIT

curl -fL --retry 3 \
    "https://download.tastytrade.com/desktop-2.0/tastytrade-mac-${mac_arch}-latest.dmg" \
    -o "$temp_dir/installer.dmg"
hdiutil attach -quiet -nobrowse -readonly -mountpoint "$mount_dir" "$temp_dir/installer.dmg"
mounted=1

if [ ! -d "$mount_dir/tastytrade 2.0.app" ]; then
    echo "tastytrade 2.0.app was not found in the downloaded disk image." >&2
    exit 1
fi

ditto "$mount_dir/tastytrade 2.0.app" "/Applications/tastytrade 2.0.app"

# The Homebrew cask installs Desktop 1.0, which tastytrade keeps in maintenance mode.
if brew list --cask tastytrade &>/dev/null; then
    brew uninstall --cask tastytrade
fi

echo "tastytrade Desktop 2.0 is installed. Open it and sign in."
