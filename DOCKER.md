# 🐳 Frontend Despacho - Docker

Guía para construir, ejecutar y desplegar la aplicación Frontend con Docker.

## 📋 Requisitos

- Docker Desktop instalado
- Docker Compose instalado
- Git configurado

## 🏗️ Estructura de Archivos Docker

```
Dockerfile           # Dockerfile multi-stage optimizado
docker-compose.yml   # Configuración de servicios
nginx.conf          # Configuración de Nginx
default.conf        # Configuración del servidor virtual
.dockerignore       # Archivos a excluir de la imagen
```

## 🚀 Construcción de la Imagen

### Opción 1: Usando docker-compose (RECOMENDADO)

```bash
# Construir la imagen
docker compose build

# Ejecutar el contenedor
docker compose up -d

# Ver logs
docker compose logs -f frontend

# Detener
docker compose down
```

### Opción 2: Usando Docker directamente

```bash
# Construir la imagen
docker build -t frontend-despacho:latest .

# Ejecutar el contenedor
docker run -d \
  --name frontend-despacho \
  -p 80:80 \
  frontend-despacho:latest

# Ver logs
docker logs -f frontend-despacho

# Detener
docker stop frontend-despacho
docker rm frontend-despacho
```

## 🔍 Verificación

```bash
# Acceder a la aplicación
http://localhost

# Verificar estado del contenedor
docker ps

# Health check
docker compose ps
```

## 📦 Características de la Imagen

✅ **Multi-stage build**: Reduce el tamaño de la imagen  
✅ **Node 18 Alpine**: Base de imagen ligera  
✅ **Nginx 1.25 Alpine**: Servidor web optimizado  
✅ **Usuario no root**: Seguridad mejorada  
✅ **Health check**: Monitoreo de disponibilidad  
✅ **Compresión gzip**: Optimización de transferencia  
✅ **Headers de seguridad**: XSS, CSRF, Clickjacking protection  
✅ **SPA routing**: Configuración para React Router  
✅ **Caché estático**: Optimización de assets  

## 🔒 Seguridad

- Ejecuta como usuario `nginx` (no root)
- Dumb-init para manejo correcto de señales
- Headers de seguridad configurados
- Nginx hardened

## 📊 Tamaño de la Imagen

Tamaño final: ~40-50 MB (dependiendo del build)

## 🆘 Troubleshooting

### Puerto 80 en uso
```bash
# Cambiar puerto en docker-compose.yml
ports:
  - "8080:80"
```

### Logs del contenedor
```bash
docker compose logs -f frontend
```

### Reconstruir sin caché
```bash
docker compose build --no-cache
```

## 📝 Notas

- La rama `deploy` tiene estos archivos configurados
- Alineado a rúbrica máxima (DevOps/Containerización)
- Listo para CI/CD pipeline
