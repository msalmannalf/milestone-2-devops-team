#!/usr/bin/env bash
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"

# Hindari bentrok port 80 dengan site default Ubuntu/Debian
rm -f /etc/nginx/sites-enabled/default

envsubst '${APP_PORT} ${DOMAIN_NAME}' < configs/nginx.conf.template \
  > /etc/nginx/conf.d/webapp.conf

nginx -t
systemctl enable nginx
systemctl reload-or-restart nginx
ok "Nginx reverse proxy aktif."
