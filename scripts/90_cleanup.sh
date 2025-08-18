#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/_lib.sh"; check_ns
envsubst < manifests/cleanup/delete-all.yaml | kubectl delete -f - --ignore-not-found
ok "Deleted app/ingress resources in $NS"
