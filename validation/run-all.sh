#!/usr/bin/env bash

# run-all.sh
# Main test suite runner executing all application templates validations.

set -uo pipefail

log_section() {
    echo "===================================================="
    echo "  $1"
    echo "===================================================="
}

EXIT_CODE=0

log_section "Starting Platform Application Templates Verification Audit"

# Run checks
./validation/check-charts.sh || EXIT_CODE=1
./validation/check-dockerfiles.sh || EXIT_CODE=1

if [ $EXIT_CODE -ne 0 ]; then
    echo "Templates verification FAILED! One or more checks failed."
    exit 1
else
    echo "Templates verification SUCCESS! Reusable charts and Dockerfiles conform to standard specifications."
    exit 0
fi
