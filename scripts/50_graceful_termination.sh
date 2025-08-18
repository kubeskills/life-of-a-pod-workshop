#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"; check_ns

POD=$(kubectl -n "$NS" get pod -l app=web -o jsonpath='{.items[0].metadata.name}')
warn "Starting endpoints watch in background (10s)…"
( kubectl -n "$NS" get endpoints web -w & echo $! > /tmp/epwatch.pid ) || true
sleep 2

warn "Deleting pod $POD (grace=15s)…"
kubectl -n "$NS" delete pod "$POD" --grace-period=15

sleep 12
kill "$(cat /tmp/epwatch.pid)" 2>/dev/null || true
ok "Observe: readiness -> endpoints update -> preStop sleep -> SIGTERM -> exit"
