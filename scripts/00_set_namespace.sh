#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"

check_ns
kubectl get ns "$NS" >/dev/null || { err "Namespace $NS not found. Ask instructor."; exit 1; }
kubectl config set-context --current --namespace="$NS" >/dev/null
ok "Context pinned to namespace: $NS"
kubectl -n "$NS" get pods