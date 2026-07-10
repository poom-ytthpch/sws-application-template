#!/usr/bin/env bash

# check-dockerfiles.sh
# Audits Dockerfile references availability.

set -euo pipefail

log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
log_err()  { echo -e "\033[0;31m[ERROR]\033[0m $1"; }

log_info "Verifying Dockerfile templates exist in scaffolds..."
if [ ! -f templates/nestjs-api/Dockerfile ]; then
    log_err "NestJS Dockerfile missing!"
    exit 1
fi
log_info "  - NestJS Dockerfile exists."

if [ ! -f templates/nextjs-frontend/Dockerfile ]; then
    log_err "Next.js Dockerfile missing!"
    exit 1
fi
log_info "  - Next.js Dockerfile exists."

if [ ! -f templates/worker-async/Dockerfile ]; then
    log_err "Worker Dockerfile missing!"
    exit 1
fi
log_info "  - Worker Dockerfile exists."

log_info "Dockerfile templates validated."
