#!/usr/bin/env bash
# CountForge personal desktop launcher installer. No root privileges, no system modifications.
set -euo pipefail
BASE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP="CountForge_v0.3.0-alpha.3.html"
DATADIR="${XDG_DATA_HOME:-$HOME/.local/share}"
APPDIR="$DATADIR/countforge"
ICONDIR="$DATADIR/icons/hicolor"
DESKTOP="$DATADIR/applications/org.digimancer3d.CountForge.desktop"
DESKTOP_ID='org.digimancer3d.CountForge'
usage(){ cat <<'EOF'
CountForge Linux desktop installer (CachyOS / Arch / KDE / other Linux)
Usage: bash install_linux.sh install | remove | status

Installs the standalone HTML, a local launcher and an icon under your home directory.
No sudo, no Python runtime and no Internet connection are required for the app.
Your browser controls saved data; export a CountForge machine backup before upgrades.
EOF
}
install_cf(){
  [[ -f "$BASE/$APP" ]] || { echo "Missing $BASE/$APP" >&2; exit 1; }
  mkdir -p "$APPDIR" "$DATADIR/applications" "$ICONDIR/scalable/apps"
  install -m 644 "$BASE/$APP" "$APPDIR/CountForge.html"
  install -m 644 "$BASE/assets/countforge-emblem.svg" "$ICONDIR/scalable/apps/$DESKTOP_ID.svg"
  for sz in 64 128 256 512; do
    mkdir -p "$ICONDIR/${sz}x${sz}/apps"
    install -m 644 "$BASE/assets/countforge-${sz}.png" "$ICONDIR/${sz}x${sz}/apps/$DESKTOP_ID.png"
  done
  cat > "$APPDIR/launch.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
APPDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# Encode common URL-reserved characters without requiring Python or another runtime.
P="$APPDIR/CountForge.html"
URL="file://${P//%/%25}"
URL="${URL// /%20}"
URL="${URL//\#/%23}"
URL="${URL//\?/%3F}"
# Default to LibreWolf; fall back to other Firefox-compatible browsers, then Chromium app mode.
if command -v librewolf >/dev/null 2>&1; then exec librewolf --new-window "$URL"; fi
if command -v firefox >/dev/null 2>&1; then exec firefox --new-window "$URL"; fi
for browser in chromium ungoogled-chromium chromium-browser google-chrome; do
  if command -v "$browser" >/dev/null 2>&1; then exec "$browser" --app="$URL" --class=countforge; fi
done
if command -v xdg-open >/dev/null 2>&1; then exec xdg-open "$URL"; fi
printf '%s\n' "Open this file in a browser: $APPDIR/CountForge.html" >&2
exit 1
EOF
  chmod 755 "$APPDIR/launch.sh"
  # XDG Desktop Entry string quoting: Exec accepts an executable path enclosed in double quotes.
  cat > "$DESKTOP" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=CountForge
GenericName=Calculator Inventory Desk
Comment=Dockable calculator inventory system; offline and portable
Exec="$APPDIR/launch.sh"
Icon=$DESKTOP_ID
Terminal=false
StartupNotify=true
StartupWMClass=countforge
Categories=Office;
Keywords=inventory;calculator;stock;ledger;offline;
EOF
  chmod 644 "$DESKTOP"
  command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$DATADIR/applications" >/dev/null 2>&1 || true
  command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true
  printf 'Installed CountForge desktop launcher.\nApp: %s\nDesktop entry: %s\n\n' "$APPDIR/CountForge.html" "$DESKTOP"
  echo 'Open CountForge from your application menu; or run:'
  printf '  "%s/launch.sh"\n' "$APPDIR"
}
remove_cf(){
  rm -f -- "$DESKTOP" "$APPDIR/launch.sh" "$APPDIR/CountForge.html"
  for sz in 64 128 256 512; do rm -f -- "$ICONDIR/${sz}x${sz}/apps/$DESKTOP_ID.png"; done
  rm -f -- "$ICONDIR/scalable/apps/$DESKTOP_ID.svg"
  rmdir -- "$APPDIR" 2>/dev/null || true
  command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$DATADIR/applications" >/dev/null 2>&1 || true
  echo 'Removed CountForge launcher/app/icon. Browser-stored inventory data was not touched.'
}
case "${1:-help}" in
  install) install_cf;;
  remove|uninstall) remove_cf;;
  status) if [[ -f "$DESKTOP" && -f "$APPDIR/CountForge.html" ]];then printf 'Installed: %s\n' "$APPDIR/CountForge.html";else echo 'CountForge desktop launcher is not installed.';fi;;
  help|-h|--help) usage;;
  *) usage; exit 2;;
esac
