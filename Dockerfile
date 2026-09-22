# Imagen base ligera
FROM node:22-alpine

# Directorio de trabajo
WORKDIR /app

RUN apk upgrade --no-cache

RUN npm install -g npm@latest

# Copiar archivos de dependencias y ajustar permisos para el usuario 'node'
COPY package*.json ./
RUN npm install --only=production

# Copiar el código de la aplicación
COPY . .

# Asignar propiedad de los archivos al usuario no privilegiado 'node'
RUN chown -R node:node /app

# Cambiar al usuario sin privilegios
USER node

# Exponer el puerto
EXPOSE 8080

# Comando de inicio
CMD ["npm", "start"]
