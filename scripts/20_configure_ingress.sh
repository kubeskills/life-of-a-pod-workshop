#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"; check_ns
: "${LB_IP:?LB_IP not set (export it before running)}"

envsubst < manifests/ingress/ingress-sslipio.yaml | kubectl apply -f -
ok "Ingress applied for host: app.${LB_IP}.sslip.io"
kubectl -n "$NS" describe ingress web | sed -n '1,80p'