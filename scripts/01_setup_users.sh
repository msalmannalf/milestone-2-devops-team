#!/usr/bin/env bash
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"
NOLOGIN="$(command -v nologin || echo /usr/sbin/nologin)"
getent group webapp >/dev/null || groupadd -r webapp
if ! id -u webapp >/dev/null 2>&1; then
  useradd -r -g webapp -s "$NOLOGIN" -d /var/www/webapp \
          -c "Web Application Daemon" webapp
  ok "User webapp berhasil dibuat."
else
  log "User webapp sudah tersedia."
fi
mkdir -p /var/www/webapp/data /var/log/webapp
chown -R webapp:webapp /var/www/webapp /var/log/webapp
chmod 0750 /var/www/webapp /var/log/webapp
ok "Direktori aplikasi siap."
