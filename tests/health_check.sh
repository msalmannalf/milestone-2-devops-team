#!/usr/bin/env bash
# Smoke test pasca-deploy. Jalankan: ./tests/health_check.sh
set -uo pipefail
PASS=0; FAIL=0

check() {
local name=$1; shift
if "$@" >/dev/null 2>&1; then
echo "[PASS] $name"; PASS=$((PASS + 1))
else
echo "[FAIL] $name"; FAIL=$((FAIL + 1))
fi
}

db_not_public() { ! ss -tln | awk '{print $4}' | grep -Eq '^(0\.0\.0\.0|\*|\
[::\]):3306$'; }
app_is_webapp() {
local pid; pid=$(systemctl show -p MainPID --value webapp.service)
[ "$(ps -o user= -p "$pid" | tr -d ' ')" = "webapp" ]
}
app_not_public() { ! ss -tln | awk '{print $4}' | grep -Eq 
'^(0\.0\.0\.0|\*):8000$'; }
check "webapp.service aktif"          systemctl is-active --quiet
webapp.service
check "nginx aktif"                   systemctl is-active --quiet nginx
check "mariadb aktif"                 systemctl is-active --quiet mariadb
check "webapp.service enabled"        systemctl is-enabled --quiet
webapp.service
check "App berjalan sebagai webapp"   app_is_webapp
check "HTTP 200 via nginx (port 80)"  curl -fsS http://127.0.0.1/health
check "Backend 8000 hanya loopback"   app_not_public
check "DB 3306 tidak terekspos publik" db_not_public

echo "----"
echo "Hasil: $PASS lulus, $FAIL gagal"
[ "$FAIL" -eq 0 ]
