# 🎨 Frontend Despacho - React + Vite

Interfaz de usuario moderna para la aplicación de despachos construida con React y Vite.

## 📦 Dockerfile

Este proyecto incluye un **Dockerfile multi-stage optimizado** para containerización:

```
Dockerfile              # Dockerfile multi-stage con Node.js y Nginx
```

### 🚀 Ejecución con Docker

```bash
# Construir la imagen
docker build -t frontend-despacho:latest .

# Ejecutar con docker-compose (RECOMENDADO)
docker compose up -d

# Ver logs
docker compose logs -f
```

Acceder en: [http://localhost](http://localhost)

📄 Para más información sobre Docker, consulta [DOCKER.md](./DOCKER.md)

## 🛠️ Requisitos

- Node.js 18+
- npm o pnpm
- Docker & Docker Compose (para ejecución containerizada)

## 🚀 Desarrollo Local

```bash
# Instalar dependencias
npm install

# Ejecutar servidor de desarrollo
npm run dev

# Build para producción
npm run build

# Preview del build
npm run preview
```

## 📋 Stack Tecnológico

- **React** - UI Framework
- **Vite** - Build tool y dev server
- **Tailwind CSS** - Utilidades CSS
- **Nginx** - Web server (en Docker)

## 📁 Estructura del Proyecto

```
src/
├── componentes/
│   ├── CrudAdmin.jsx
│   ├── CrudAdmin/
│   └── Layouts/
├── Routes/
│   └── AppRoutes.jsx
├── assets/
│   └── images/
├── index.css
└── main.jsx
```

## ✨ Características

- Interfaz responsiva
- Componentes reutilizables
- Routing avanzado
- Tailwind CSS integrado
- Hot Module Replacement (HMR)

## 📚 Documentación

- [Guía Docker](./DOCKER.md)
- [Docker Compose](./docker-compose.yml)
- [Vite Documentation](https://vitejs.dev)
- [React Documentation](https://react.dev)
