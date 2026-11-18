#!/usr/bin/env bash
# Master Idempotent Installer - jalankan: sudo ./deploy.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
source scripts/lib.sh
if [ "$(id -u)" -ne 0 ]; then
  echo "[ERROR] Jalankan dengan: sudo ./deploy.sh" >&2
  exit 1
fi
if [ -f .env ]; then
  [ "$(stat -c %a .env)" = "600" ] || chmod 600 .env
  set -a
  # shellcheck source=/dev/null
  source .env
  set +a
else
echo "[ERROR] File .env tidak ditemukan! Salin dari env.example." >&2
  exit 1
fi
: "${DB_NAME:?Variabel DB_NAME wajib didefinisikan!}"
: "${DB_USER:?Variabel DB_USER wajib didefinisikan!}"
: "${DB_PASS:?Variabel DB_PASS wajib didefinisikan!}"
export APP_PORT="${APP_PORT:-8000}"
export DOMAIN_NAME="${DOMAIN_NAME:-_}"
if [ -f /etc/os-release ]; then
  # shellcheck source=/dev/null
  . /etc/os-release
  OS_ID="$ID"
else
  echo "OS tidak dikenali!" >&2
  exit 1
fi
case "$OS_ID" in
  rhel|rocky|almalinux|fedora) FAMILY=rhel ;;
  ubuntu|debian)               FAMILY=debian ;;
  *) echo "Distro $OS_ID belum didukung!" >&2; exit 1 ;;
esac
export OS_ID FAMILY
log "Distro terdeteksi: $OS_ID (family: $FAMILY)"
for step in scripts/0[1-9]_*.sh; do
  log "=== Menjalankan $step ==="
  bash "$step"
done
ok "DEPLOY SELESAI. Uji: curl http://127.0.0.1/health"
