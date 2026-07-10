# Multi-stage production optimized Dockerfile for Next.js (SSR Mode)
# Enforces non-root execution and minimal final layer footprint

# Stage 1: Build dependency
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

# Stage 2: Runtime image runner
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Enforce secure non-root system users
RUN addgroup -g 1001 -S nodejs && adduser -u 1001 -S nextjs -G nodejs
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./package.json
USER nextjs
EXPOSE 3000
CMD ["npm", "start"]
