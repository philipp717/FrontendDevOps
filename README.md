# Arquitectura de Microservicios - Sistema de Gestión Comercial (Lift & Shift)

El proyecto consiste en el despliegue de una arquitectura de microservicios bajo el enfoque Lift & Shift en AWS.

La solución contempla:

- Frontend desplegado en una instancia pública
- Backend de Ventas
- Backend de Despachos
- Base de datos MySQL
- Contenedores Docker
- Automatización CI/CD

La infraestructura fue implementada utilizando una VPC segmentada en capas Frontend, Backend y Data.

---

## Arquitectura del Proyecto

La arquitectura está dividida en 3 capas:

| Capa | Función |
|---|---|
| Frontend | Acceso público desde Internet |
| Backend | Microservicios privados |
| Data | Base de datos MySQL privada |

---

## Tecnologías Utilizadas

- AWS EC2
- AWS VPC
- Docker
- Docker Compose
- GitHub Actions
- Docker Hub
- React
- Vite
- Nginx

---

## Estructura del Proyecto

```bash
FrontendDevOps/
│
├── src/
├── public/
├── Dockerfile
├── docker-compose.yml
├── .github/workflows/deploy.yml
└── README.md
```

---

## Funcionamiento del Proyecto

El Frontend consume servicios backend desplegados en contenedores Docker dentro de una subred privada.

El proyecto utiliza Docker para contenerización y GitHub Actions para automatizar:

- Build de imágenes
- Push a Docker Hub
- Deploy automático en AWS

---

## Cómo Utilizar el Proyecto

### 1. Clonar repositorio

```bash
git clone https://github.com/philipp717/FrontendDevOps.git
```

### 2. Entrar al proyecto

```bash
cd FrontendDevOps
```

### 3. Construir contenedor Docker

```bash
docker build -t front-devops .
```

### 4. Ejecutar contenedor

```bash
docker run -d -p 80:80 front-devops
```

---

## Docker Compose

El proyecto incluye un archivo:

```bash
docker-compose.yml
```

Permitiendo levantar el servicio automáticamente.

### Ejecución

```bash
docker compose up -d --build
```

---

## CI/CD

El proyecto implementa integración y despliegue continuo mediante GitHub Actions.

### Workflow

```
Push rama deploy
    ↓
Build Docker Image
    ↓
Push Docker Hub
    ↓
Deploy automático en AWS EC2
```

### GitHub Actions

Archivo utilizado:

```bash
.github/workflows/deploy.yml
```

Este workflow automatiza:

- Build Docker
- Push Docker Hub
- Deploy automático en EC2

---

## Seguridad

La solución considera:

- Frontend accesible únicamente por HTTP
- Backend privado
- Base de datos privada
- Restricción SSH mediante Security Groups

---

## Infraestructura AWS

La infraestructura fue desplegada utilizando:

- EC2 Ubuntu
- VPC personalizada
- Subred pública
- Subred privada
- Security Groups

---

## Commits Explicativos

El repositorio contiene commits descriptivos que permiten comprender:

- Cambios realizados
- Correcciones aplicadas
- Actualizaciones del sistema
- Implementación Docker
- Integración CI/CD

### Ejemplos

```
fix: corrige conexión backend mysql
update: agrega workflow github actions
feat: implementa docker compose
```