#!/bin/bash
set -euo pipefail

PKG_URL="<AKTO_MACOS_PKG_URL>"
PKG_PATH="/tmp/akto-endpoint-shield.pkg"

echo "[Akto] Downloading package..."
curl -fsSL "$PKG_URL" -o "$PKG_PATH"

echo "[Akto] Installing package..."
installer -pkg "$PKG_PATH" -target /

echo "[Akto] Installation script finished."
