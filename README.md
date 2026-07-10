# Golden Application Templates (sws-application-template)

This submodule manages the **Golden Application Templates**. It provides standardized Helm charts and configurations for bootstrapping new microservices.

---

## Overview

To speed up service creation while maintaining strict platform compliance, this repository distributes a golden path Helm chart:
* **Microservice Chart** (`charts/microservice`): Production-hardened Helm chart equipped with pre-configured ingress rules, security context settings, Prometheus scraping annotations, and network policies.
* **Autoscaling Options**: Out-of-the-box CPU scaling and event-driven queues autoscaling triggers (via KEDA).
* **Hardened Security Context**: Configures pod security defaults (`runAsNonRoot: true`, drops capabilities).

---

## Folders & Architecture

```
sws-application-template/
├── charts/
│   └── microservice/             # Golden path microservice Helm chart
│       ├── Chart.yaml
│       ├── templates/            # Standard manifests templates
│       └── values.yaml           # Baseline values
├── templates/                    # Custom bootstrap templates
├── validation/                   # Scaffold verification tests
└── Makefile                      # Submodule Makefile tasks
```

---

## Commands

| Command | Purpose | Example |
| :--- | :--- | :--- |
| `make verify` | Runs dry-run Helm template check | `make verify` |
| `make lint` | Validates chart and config format syntax | `make lint` |
| `make validate` | Executes template validation scripts | `make validate` |
| `make clean` | Removes temporary rendered files | `make clean` |

---

## Chart Configuration Values

The default `values.yaml` defines a set of features:

| Key | Description | Default |
| :--- | :--- | :--- |
| `replicaCount` | Number of pods to execute | `2` |
| `podSecurityContext` | Restricts container execution user ID | `runAsUser: 10001` |
| `securityContext.readOnlyRootFilesystem` | Enforces read-only root filesystems | `true` |
| `networkPolicy.enabled` | Applies default ingress NetworkPolicies | `true` |
| `keda.enabled` | Enables event-driven KEDA scaler triggers | `false` |
