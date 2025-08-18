#!/usr/bin/env bash
set -euo pipefail

color() { printf "\033[%sm%s\033[0m\n" "$1" "$2"; }
info()  { color "36" "[INFO] $*"; }
ok()    { color "32" "[OK]   $*"; }
warn()  { color "33" "[WARN] $*"; }
err()   { color "31" "[ERR]  $*"; }

require() { command -v "$1" >/dev/null || { err "Missing $1"; exit 1; }; }

check_ns() { : "${NS:?NS not set}"; }