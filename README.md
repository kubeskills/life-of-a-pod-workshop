# The Life of a Pod and Its Network Footprint on LKE

Hands-on workshop for **KCD Colombia (Aug 28)**. We’ll trace a request from **DNS → LoadBalancer (NodeBalancer) → Ingress-NGINX → Service → EndpointSlice → Pod**, inspect a pod’s network view, and watch **graceful termination**.

## Prerequisites
- `kubectl >= 1.28`, `helm >= 3.12`, `curl`, `dig`/`nslookup`.
- Access to the **shared LKE cluster** (provided by instructor).
- Your assigned **namespace** (e.g., `workshop-bogota`).

## Quickstart (copy/paste)

```bash
# 0) Set your namespace (replace!)
export NS=workshop-bogota
./scripts/00_set_namespace.sh

# 1) Deploy the demo app (Deployment + Service)
./scripts/10_deploy_app.sh

# 2) Configure Ingress host using sslip.io (needs LB_IP env)
export LB_IP=$(kubectl -n ingress-nginx get svc ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
./scripts/20_configure_ingress.sh

# 3) Verify end-to-end path (curl through ingress)
./scripts/30_verify_path.sh

# 4) Inspect from inside the pod (DNS, routes, etc.)
./scripts/40_introspect_pod.sh

# 5) Observe graceful termination & EndpointSlice updates
./scripts/50_graceful_termination.sh

# (Optional) Cleanup your namespace objects
./scripts/90_cleanup.sh
```

## What You’ll Learn
- Pod lifecycle signals (readiness, preStop, SIGTERM) and how EndpointSlices update.
- How LKE exposes services via NodeBalancer and ingress-nginx.
- Practical, baseline security hardening for demo workloads.

## Badge
Follow docs/badge-submission.md for what to capture and where to submit in [KubeSkills Community](https://community.kubeskills.com).
