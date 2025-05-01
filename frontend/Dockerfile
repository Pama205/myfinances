# Usar una imagen base de Node.js con la versión 22.12.0
FROM node:22.12.0-alpine

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Exponer el puerto en el que escucha la aplicación
EXPOSE 4000

# Comando para ejecutar la aplicación
CMD ["npm", "run", "dev"]