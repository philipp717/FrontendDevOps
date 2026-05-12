# Stage 1: Build
FROM node:18-alpine AS builder

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm ci --only=production && \
    npm ci --only=development && \
    npm cache clean --force

# Copiar código fuente
COPY . .

# Construir la aplicación Vite
RUN npm run build

# Stage 2: Producción con Nginx
FROM nginx:1.25-alpine

# Variables de etiqueta
LABEL maintainer="Philipp Reyes <philipp@example.com>" \
      version="1.0" \
      description="Frontend Despacho - Aplicación React con Vite"

# Instalar dumb-init para manejar señales correctamente
RUN apk add --no-cache dumb-init

# Copiar configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Copiar archivos compilados desde builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Asignar permisos correctos (usar usuario nginx que ya existe en nginx:alpine)
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Usuario no root
USER nginx

# Exponer puerto
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

# Usar dumb-init para ejecutar Nginx
ENTRYPOINT ["/sbin/dumb-init", "--"]
CMD ["nginx", "-g", "daemon off;"]
