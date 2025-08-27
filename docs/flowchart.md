```mermaid
flowchart LR
  %% External
  subgraph "External"
    U[User (curl/browser)]
    DNS[sslip.io DNS]
    LB[(LKE NodeBalancer\nEXTERNAL-IP)]
    U -->|"http://app.${LB_IP}.sslip.io"| DNS --> LB
  end

  %% ingress-nginx namespace
  subgraph "ingress-nginx namespace"
    SvcLB[Service ingress-nginx-controller\nType=LoadBalancer\nPorts 80/443]
    Ctrl[Deployment/DaemonSet\ningress-nginx-controller\nPods xN]
    SvcMet[Service ingress-nginx-controller-metrics\n:10254]
    SvcAdm[Service ingress-nginx-controller-admission\n443 ➜ 8443]
    VWC[ValidatingWebhookConfiguration\ningress-nginx-admission]
    NP_http[NetworkPolicy allow-http (80/443)]
    NP_metrics[NetworkPolicy allow-prometheus-to-metrics (10254)]
    NP_adm[NetworkPolicy allow-admission (8443)]
    SvcLB -->|selects| Ctrl
  end
  LB --> SvcLB

  %% workshop namespace
  subgraph "workshop-bogota namespace"
    Ingr[Ingress web\nhost=app.${LB_IP}.sslip.io\nclass: nginx]
    SvcWeb[Service web\n80 ➜ 8080 (ClusterIP)]
    ES[EndpointSlices for web]
    Dep[Deployment web (replicas=2)]
    Pods[(Pods: echoserver/agnhost)]
    NP_ws[NetworkPolicy baseline:\nallow from ingress-nginx ➜ 8080]
    SA[ServiceAccount: student]
    Ingr --> SvcWeb --> ES --> Pods
  end
  Ctrl -->|routes| Ingr

  %% monitoring namespace
  subgraph "monitoring namespace"
    Prom[Prometheus (kube-prometheus-stack)]
    SM[ServiceMonitor ingress-nginx]
    Graf[Grafana Service]
    RB_pf[Role/RoleBindings for students\n(pods/portforward)]
    SM --> Prom --> Graf
  end
  SvcMet --> SM

  %% Styling
  classDef svc fill:#E6F7FF,stroke:#0AA,stroke-width:1px;
  classDef ctrl fill:#FFF7CC,stroke:#AA0,stroke-width:1px;
  classDef np fill:#FFE6E6,stroke:#A00,stroke-width:1px;
  class SvcLB,SvcMet,SvcAdm,SvcWeb,Graf svc;
  class Ctrl ctrl;
  class NP_http,NP_metrics,NP_adm,NP_ws np;

```