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
  echo -e "║                              ⚡ SHADOWHUB ⚡                           ║"
  echo -e "║                            ✦ SHADOW EDITION ✦                       ║"
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
    1) echo; echo "Pterodactyl Panel installer is not configured yet."; read -rp "Press Enter to return..." ;;
    2) echo; echo "=== WINGS MANAGER ==="; if command -v docker >/dev/null 2>&1; then docker --version; else echo "Docker is not installed."; fi; read -rp "Press Enter to return..." ;;
    3)
      while true; do
        clear
        echo -e "${C}╔══════════════════════════════════════════════════════════════════════════════╗"
        echo -e "║                           SHADOWHUB THEMES                                 ║"
        echo -e "╠══════════════════════════════════════════════════════════════════════════════╣"
        echo -e "║  ${P}[1]${R} Hyper-V2 Theme                                                        ${C}║"
        echo -e "║  ${P}[2]${R} Blueprint                                                            ${C}║"
        echo -e "║  ${P}[3]${R} Extensions                                                           ${C}║"
        echo -e "║  ${P}[4]${R} Scan Installed Themes                                                ${C}║"
        echo -e "║  ${Y}[0]${R} Back                                                                 ${C}║"
        echo -e "╚══════════════════════════════════════════════════════════════════════════════╝${R}"
        read -rp "Select option: " t
        case "$t" in
          1) clear; echo "=== HYPER-V2 THEME ==="; if [ ! -d /var/www/pterodactyl ]; then echo "Pterodactyl panel not found."; elif [ -x /opt/shadowhub/hyper-utility ]; then echo "Utility found; inspect its usage before execution."; else echo "Hyper-V2 utility not installed."; fi; read -rp "Press Enter to return..." ;;
          2) echo "Blueprint selected. Installer source not configured."; read -rp "Press Enter..." ;;
          3) echo "Extensions selected. Installer source not configured."; read -rp "Press Enter..." ;;
          4) if [ -d /var/www/pterodactyl ]; then find /var/www/pterodactyl -maxdepth 4 -type d 2>/dev/null | grep -Ei "theme|hyper|blueprint|extension|arix" | head -40 || true; else echo "Pterodactyl directory not found."; fi; read -rp "Press Enter..." ;;
          0) break ;;
          *) echo "Invalid option"; sleep 1 ;;
        esac
      done ;;
    4) echo; echo "=== TOOLBOX ==="; echo "[1] System info  [2] Disk usage  [3] Memory usage"; read -rp "Choose: " tool; case "$tool" in 1) uname -a; uptime ;; 2) df -h ;; 3) free -h ;; *) echo "Invalid option" ;; esac; read -rp "Press Enter to return..." ;;
    *) echo "Invalid option."; sleep 1 ;;
  esac
done
