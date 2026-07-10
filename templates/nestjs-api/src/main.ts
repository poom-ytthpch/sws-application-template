import { otelSDK } from './tracing';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  // Start OpenTelemetry SDK first
  otelSDK.start();
  console.log('OpenTelemetry SDK initialized.');

  const app = await NestFactory.create(AppModule);
  
  // Enable graceful shutdown hooks (forces database connection closing on SIGTERM)
  app.enableShutdownHooks();

  const port = process.env.PORT || 3000;
  await app.listen(port);
  console.log(`NestJS Golden API is listening on port: ${port}`);
}

bootstrap();
