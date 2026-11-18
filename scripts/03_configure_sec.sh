#!/usr/bin/env bash
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"
if command -v ufw >/dev/null 2>&1 && ufw status | grep -q "Status: active"; then
  ufw allow 80/tcp
  log "ufw: port 80 diizinkan."
fi
if command -v firewall-cmd >/dev/null 2>&1 && systemctl is-active --quiet firewalld; then
  firewall-cmd --permanent --add-service=http
  firewall-cmd --reload
  log "firewalld: service http diizinkan."
fi
if command -v getenforce >/dev/null 2>&1 && [ "$(getenforce)" = "Enforcing" ]; then
  setsebool -P httpd_can_network_connect 1
  log "SELinux: httpd_can_network_connect=1"
fi
ok "Konfigurasi keamanan selesai."
