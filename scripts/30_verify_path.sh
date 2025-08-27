#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"; check_ns
: "${LB_IP:?LB_IP not set}"

info "DNS resolves to:"
dig +short "app.${LB_IP}.sslip.io" || true

info "Curl through ingress (expect pod hostname):"
curl -sS "http://app.${LB_IP}.sslip.io/hostname"