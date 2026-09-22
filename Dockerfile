# Imagen base ligera
FROM node:22-alpine

# Directorio de trabajo
WORKDIR /app

# Actualizar paquetes del sistema base
RUN apk upgrade --no-cache 

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar solo dependencias de producción y limpiar caché
RUN npm ci --only=production && npm cache clean --force

# Copiar el código de la aplicación
COPY . .

# Asignar propiedad de los archivos al usuario no privilegiado 'node'
RUN chown -R node:node /app

# Cambiar al usuario sin privilegios
USER node

# Exponer el puerto
EXPOSE 8080

# Comando de inicio recomendado (ejecuta node directamente)
CMD ["node", "index.js"]

