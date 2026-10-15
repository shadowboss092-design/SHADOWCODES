#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo "Run as root: sudo bash install.sh"
    exit 1
fi

BASE="https://raw.githubusercontent.com/shadowboss092-design/SHADOWCODES/main"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$BASE/shadowhub.sh" -o "$TMP/shadowhub.sh"

mkdir -p /opt/shadowhub
install -m 755 "$TMP/shadowhub.sh" /opt/shadowhub/shadowhub.sh

cat > /usr/local/bin/shadowhub <<'LAUNCHER'
#!/bin/bash
exec bash /opt/shadowhub/shadowhub.sh "$@"
LAUNCHER

chmod 755 /usr/local/bin/shadowhub

echo "SHADOWHUB installed successfully!"
echo "Run: shadowhub"
