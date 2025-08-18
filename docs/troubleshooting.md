## Troubleshooting

- **No EXTERNAL-IP on ingress-nginx-controller**: wait 1–2 mins; or verify LKE NodeBalancer quota.
- **404 from Ingress**: check host in rule matches `app.${LB_IP}.sslip.io`; verify `ingressClassName: nginx`.
- **Service has no endpoints**: `kubectl -n $NS get pods -l app=web -o wide`; check readiness probe.
- **DNS issues**: `kubectl -n kube-system logs -l k8s-app=kube-dns` or `coredns`.
