import { Worker, Job } from 'bullmq';
import Queue from 'bullmq';
import Redis from 'ioredis';

const REDIS_HOST = process.env.REDIS_HOST || 'localhost';
const REDIS_PORT = parseInt(process.env.REDIS_PORT || '6379');

const connection = new Redis({
  host: REDIS_HOST,
  port: REDIS_PORT,
  maxRetriesPerRequest: null,
});

console.log(`Connecting to Redis queue host: ${REDIS_HOST}:${REDIS_PORT}`);

// Initialize BullMQ Worker loop processing tasks
const worker = new Worker(
  'platform-task-queue',
  async (job: Job) => {
    console.log(`Processing job ID: ${job.id}, payload:`, job.data);
    
    // Simulate workload execution
    await new Promise((resolve) => setTimeout(resolve, 500));
    
    return { status: 'success' };
  },
  { connection }
);

worker.on('completed', (job) => {
  console.log(`Job ID ${job.id} completed successfully.`);
});

worker.on('failed', (job, err) => {
  console.error(`Job ID ${job?.id} failed with error:`, err);
});
