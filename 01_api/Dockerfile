FROM node:20-alpine

WORKDIR /app

# Copy package files and install production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Healthcheck endpoint for docker
HEALTHCHECK --interval=5s --timeout=3s --retries=5 CMD curl -f http://localhost:3001/health || exit 1

EXPOSE 3001
CMD ["node", "index.js"]
