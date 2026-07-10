#!/usr/bin/env bash

# check-charts.sh
# Verifies microservice base Helm chart compilation.

set -euo pipefail

log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
log_err()  { echo -e "\033[0;31m[ERROR]\033[0m $1"; }

log_info "Verifying Helm chart syntax and template compilation..."
if ! helm template test-release charts/microservice/ &>/dev/null; then
    log_err "Helm template rendering failed!"
    exit 1
fi
log_info "  - Base microservice Helm chart compiles."

log_info "Helm chart verification completed."
