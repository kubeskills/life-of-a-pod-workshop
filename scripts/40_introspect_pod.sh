#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"; check_ns

POD=$(kubectl -n "$NS" get pod -l app=web -o jsonpath='{.items[0].metadata.name}')
info "Introspecting $POD"
kubectl -n "$NS" exec -it "$POD" -- sh -lc '
  echo "--- IP addresses ---"; ip addr || ifconfig;
  echo "--- Routes ---"; ip route;
  echo "--- resolv.conf ---"; cat /etc/resolv.conf;
  echo "--- DNS lookup for service ---"; getent hosts web.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local || nslookup web;
'
