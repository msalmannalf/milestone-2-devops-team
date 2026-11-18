#!/usr/bin/env bash
# Library bersama: strict mode, logging, error trapping.
set -Eeuo pipefail
IFS=$'\n\t'
log()  { echo "[INFO] $*"; }
ok()   { echo "[SUCCESS] $*"; }
warn() { echo "[WARN] $*" >&2; }
error_handler() {
  local line_no=$1
  local last_command=$2
  echo "[CRITICAL ERROR] Perintah '${last_command}' gagal di bar  is ${line_no}!" >&2
  exit 1
}
trap 'error_handler $LINENO "$BASH_COMMAND"' ERR
trap 'echo "[INFO] Skrip dibatalkan oleh pengguna." >&2; exit 130' INT TERM
