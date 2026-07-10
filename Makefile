# Makefile for Golden Application Templates (platform-application-template)
# Automates validation of Dockerfiles, Helm charts, and GHA workflows.

.PHONY: help lint verify validate clean

help:
	@echo "Available commands:"
	@echo "  lint      - Validate YAML and run linter checks"
	@echo "  verify    - Verify Helm chart templates compile properly"
	@echo "  validate  - Run all validation and scaffold verification checks"
	@echo "  clean     - Remove temporary build outputs"

lint:
	@echo "Linting configs..."
	yamllint -c .yamllint.yaml .

verify:
	@echo "Verifying local microservice Helm chart templates..."
	helm template test-service charts/microservice/

validate:
	@echo "Executing validation scripts suite..."
	./validation/run-all.sh

clean:
	@echo "Cleaning up local outputs..."
	rm -rf /tmp/rendered-templates.yaml
