# Multi-stage production optimized Dockerfile for NestJS API
# Enforces non-root execution and minimal final layer footprint

# Stage 1: Build dependency
FROM node:18-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

# Stage 2: Runtime image runner
FROM node:18-alpine AS runner
WORKDIR /usr/src/app
ENV NODE_ENV=production

# Enforce secure non-root system users
RUN addgroup -g 1001 -S nodejs && adduser -u 1001 -S nestjs -G nodejs
COPY --from=builder --chown=nestjs:nodejs /usr/src/app/dist ./dist
COPY --from=builder --chown=nestjs:nodejs /usr/src/app/node_modules ./node_modules
USER nestjs
EXPOSE 3000
CMD ["node", "dist/main.js"]
