```mermaid
flowchart LR
  %% External-facing path
  subgraph "External"
    U[User]
    DNS[sslip.io DNS]
    LB[(LKE NodeBalancer)]
    U --> DNS --> LB
  end

  %% Ingress NGINX stack
  subgraph "ingress-nginx"
    SvcLB[Service ingress-nginx-controller<br/>Type=LoadBalancer<br/>Ports 80,443]
    Ctrl[Ingress NGINX controller pods]
    SvcMet[Service metrics :10254]
    SvcAdm[Service admission :443 -> 8443]
    VWC[ValidatingWebhookConfiguration]
    SvcLB --> Ctrl
  end
  LB --> SvcLB

  %% App namespace
  subgraph "workshop-bogota"
    Ingr[Ingress web host app.${LB_IP}.sslip.io]
    SvcWeb[Service web 80 -> 8080]
    ES[EndpointSlices web]
    Dep[Deployment web (replicas 2)]
    Pods[Pods]
    Ingr --> SvcWeb --> ES --> Pods
  end
  Ctrl --> Ingr

  %% Monitoring stack
  subgraph "monitoring"
    Prom[Prometheus]
    SM[ServiceMonitor ingress-nginx]
    Graf[Grafana]
    SM --> Prom --> Graf
  end

  SvcMet --> SM


```