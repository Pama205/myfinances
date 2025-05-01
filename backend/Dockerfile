# Usar una imagen base de Node.js con la versión 20.18.1
FROM --platform=linux/amd64 node:20.18.1-bullseye

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias de producción
RUN npm install --omit=dev

# Copiar el resto del código fuente
COPY . .

# Instalar bcrypt con la arquitectura correcta
RUN npm install bcrypt --platform=linux/amd64 --arch=x64

# Exponer el puerto en el que escucha la aplicación
EXPOSE 3000

# Comando para ejecutar la aplicación (corregido)
CMD ["node", "src/app.js"]