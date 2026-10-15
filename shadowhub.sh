#!/bin/bash

R='\033[0m'; C='\033[1;36m'; P='\033[1;35m'
G='\033[1;32m'; Y='\033[1;33m'; W='\033[1;37m'

while true; do
  clear
  CPU=$(top -bn1 2>/dev/null | awk -F'[, ]+' '/Cpu\(s\)/ {for(i=1;i<=NF;i++) if($i=="id") {print 100-$(i-1); exit}}')
  [ -z "$CPU" ] && CPU="N/A"
  read RAM_USED RAM_TOTAL < <(free -h | awk '/^Mem:/ {print $3, $2}')
  RAM_PERCENT=$(free | awk '/^Mem:/ {printf "%d", $3*100/$2}')
  read DISK_USED DISK_TOTAL DISK_PERCENT < <(df -hP / | awk 'NR==2 {print $3, $2, $5}')
  if curl -fsS --max-time 2 https://example.com >/dev/null 2>&1; then NET="CONNECTED"; else NET="OFFLINE"; fi

  echo -e "${C}╔══════════════════════════════════════════════════════════════════════════════╗"
  echo -e "║                              SHADOWHUB                                     ║"
  echo -e "║                            SHADOW EDITION                                  ║"
  echo -e "╚══════════════════════════════════════════════════════════════════════════════╝${R}"
  echo
  echo -e "${P}◉ SYSTEM STATUS${R}"
  echo -e " CPU: ${Y}${CPU}%${R}   RAM: ${Y}${RAM_PERCENT}% (${RAM_USED}/${RAM_TOTAL})${R}   Network: ${G}${NET}${R}"
  echo -e " Disk: ${Y}${DISK_USED}/${DISK_TOTAL} (${DISK_PERCENT})${R}"
  echo
  echo -e "${C}◆ DEPLOYMENT & SERVICES${R}"
  echo -e " [1] Pterodactyl Panel"
  echo -e " [2] Wings Manager"
  echo -e " [3] Themes"
  echo -e " [4] Toolbox"
  echo
  echo -e "${C}────────────────────────────────────────────────────────────────────────────────${R}"
  read -rp "➜ Select option (0-4): " choice

  case "$choice" in
    0) echo "SHADOWHUB closed."; exit 0 ;;
    1) echo "Panel installer is not connected yet."; read -rp "Press Enter to return..." ;;
    2) echo "Wings installer is not connected yet."; read -rp "Press Enter to return..." ;;
    3) echo "Themes menu is not configured yet."; read -rp "Press Enter to return..." ;;
    4) echo "Toolbox is not configured yet."; read -rp "Press Enter to return..." ;;
    *) echo "Invalid option."; sleep 1 ;;
  esac
done
