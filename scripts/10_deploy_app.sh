#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"; check_ns

envsubst < manifests/app/deployment.yaml | kubectl apply -f -
envsubst < manifests/app/service.yaml     | kubectl apply -f -
kubectl -n "$NS" rollout status deploy/web
ok "App deployed"
kubectl -n "$NS" get svc,pods -o wide
kubectl -n "$NS" get endpointslices -l kubernetes.io/service-name=web