import { NodeSDK } from '@opentelemetry/sdk-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-grpc';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';

// Initialize the OpenTelemetry Node SDK
const traceExporter = new OTLPTraceExporter({
  url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'grpc://otel-collector.monitoring.svc.cluster.local:4317',
});

export const otelSDK = new NodeSDK({
  traceExporter,
  instrumentations: [getNodeAutoInstrumentations()],
});

// Graceful shut down of SDK on process terminations
process.on('SIGTERM', () => {
  otelSDK.shutdown()
    .then(() => console.log('OTel SDK successfully shutdown.'))
    .catch((err) => console.error('Error shutting down OTel SDK:', err))
    .finally(() => process.exit(0));
});
