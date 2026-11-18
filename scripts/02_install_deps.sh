#!/usr/bin/env bash
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"
case "$FAMILY" in
  debian)
    export DEBIAN_FRONTEND=noninteractive
    log "Instalasi paket (Debian/Ubuntu family)..."
    apt-get update -y
    apt-get install -y nginx mariadb-server python3 python3-pip gettext-base curl
    ;;
  rhel)log "Instalasi paket (RHEL family)..."
    dnf install -y nginx mariadb-server python3 python3-pip gettext
    ;;
  *)
    echo "[ERROR] FAMILY '$FAMILY' tidak dikenali" >&2
    exit 1
    ;;
esac
ok "Dependensi terpasang."
