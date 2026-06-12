FROM node:22-bookworm-slim AS deps

WORKDIR /app

COPY package*.json ./

COPY prisma ./prisma

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN npm ci

RUN npx prisma generate

FROM deps AS builder

COPY nest-cli.json ./
COPY tsconfig*.json ./
COPY src ./src

RUN npm run build

FROM node:22-bookworm-slim AS runner

WORKDIR /app


COPY package*.json ./
COPY prisma ./prisma

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*


ENV NODE_ENV=production

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

EXPOSE 3333

CMD ["node", "dist/main.js"]
