#!/usr/bin/env bash
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"

install -o webapp -g webapp -m 0640 app/app.py /var/www/webapp/app.py
install -o root -g root -m 0644 systemd/webapp.service /etc/systemd/system/webapp.service

systemctl daemon-reload
systemctl enable webapp.service
systemctl restart webapp.service

for _ in $(seq 1 10); do
  if curl -fsS "http://127.0.0.1:${APP_PORT}/health" >/dev/null 2>&1; then
    ok "webapp.service berjalan dan sehat."
    exit 0
  fi
  sleep 1
done

echo "[ERROR] webapp tidak merespons /health" >&2
journalctl -u webapp.service -n 20 --no-pager >&2
exit 1
