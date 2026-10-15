#!/bin/bash
set -e

SOURCE="$(cd -- "$(dirname -- "$0")" && pwd)/shadowhub.sh"
TARGET="/opt/shadowhub/shadowhub.sh"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo bash install.sh"
    exit 1
fi

if [ ! -f "$SOURCE" ]; then
    echo "ERROR: shadowhub.sh not found!"
    exit 1
fi

mkdir -p /opt/shadowhub
install -m 755 "$SOURCE" "$TARGET"

cat > /usr/local/bin/shadowhub <<'LAUNCHER'
#!/bin/bash
exec bash /opt/shadowhub/shadowhub.sh "$@"
LAUNCHER

chmod 755 /usr/local/bin/shadowhub

echo "SHADOWHUB installed successfully!"
echo "Run it using: shadowhub"
