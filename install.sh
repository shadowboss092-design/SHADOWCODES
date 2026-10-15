#!/bin/bash
set -e

SOURCE="/root/shadowhub.sh"
TARGET="/opt/shadowhub/shadowhub.sh"

if [ ! -f "$SOURCE" ]; then
    echo "ERROR: /root/shadowhub.sh not found!"
    exit 1
fi

mkdir -p /opt/shadowhub
cp "$SOURCE" "$TARGET"
chmod +x "$TARGET"

cat > /usr/local/bin/shadowhub <<'LAUNCHER'
#!/bin/bash
exec bash /opt/shadowhub/shadowhub.sh "$@"
LAUNCHER

chmod +x /usr/local/bin/shadowhub

echo "SHADOWHUB installed successfully!"
echo "Run it using: shadowhub"
