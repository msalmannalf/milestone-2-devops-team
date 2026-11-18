#!/usr/bin/env bash
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"

case "$FAMILY" in
  debian) CNF_DEST=/etc/mysql/mariadb.conf.d/99-hardening.cnf ;;
  rhel)   CNF_DEST=/etc/my.cnf.d/99-hardening.cnf ;;
  *) echo "[ERROR] FAMILY tidak dikenali" >&2; exit 1 ;;
esac

systemctl enable --now mariadb

if ! cmp -s configs/database.cnf "$CNF_DEST" 2>/dev/null; then
  install -D -m 0644 configs/database.cnf "$CNF_DEST"
  systemctl restart mariadb
  log "Hardening DB diterapkan."
fi

# Catatan: DB_PASS tidak boleh mengandung tanda petik tunggal (')
mysql -u root <<SQL
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
ALTER USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
SQL

ok "Database ${DB_NAME} dan user ${DB_USER} siap."
