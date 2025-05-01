FROM node:18-alpine

WORKDIR /app

# 1) instalar as dependências de produção
COPY package*.json ./
RUN npm ci --only=production

# 2) copiar o código compilado
COPY dist ./dist

# 3) copiar e renomear o template de .env
#    agora, dentro do container, haverá um arquivo .env idêntico ao example
COPY .env.example .env

# 4) definir variáveis de ambiente
ENV NODE_ENV=production

# 5) expor porta (WebSocket / HTTP)
EXPOSE 3000

# 6) comando de inicialização
CMD ["node", "dist/index.js"]
