# Frontend DevOps en AWS EKS

Frontend desarrollado con React y Vite, compilado en una imagen Docker multi-stage y servido con Nginx. El despliegue productivo está preparado para Kubernetes en Amazon EKS, con imágenes almacenadas en Amazon ECR y automatización mediante GitHub Actions.

## Tecnologías

- React y Vite
- Nginx
- Docker
- Kubernetes
- Amazon EKS
- Amazon ECR
- GitHub Actions

## Estructura relevante

```text
FrontendDevOps/
├── src/
├── public/
├── k8s/
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   └── frontend-hpa.yaml
├── .github/workflows/deploy-eks.yml
├── Dockerfile
├── nginx.conf
├── default.conf
└── README.md
```

## Contenedor

El `Dockerfile` utiliza dos etapas:

1. Node.js instala las dependencias y ejecuta el build de Vite.
2. Nginx sirve el contenido generado en `dist` por el puerto 80.

Construcción y ejecución local:

```bash
docker build -t frontend-devops:latest .
docker run --rm -p 80:80 frontend-devops:latest
```

La aplicación quedará disponible en `http://localhost`.

## Despliegue en Kubernetes

Los manifiestos de `k8s/` crean los siguientes recursos en el namespace `devops`:

- Deployment `frontend-devops` con 2 réplicas iniciales.
- Service `frontend-devops` de tipo `LoadBalancer` en el puerto 80.
- HPA `frontend-devops` entre 2 y 5 réplicas, con objetivo promedio de CPU del 50 %.

La imagen configurada en el Deployment utiliza este formato:

```text
ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com/frontend-devops:latest
```

El workflow reemplaza automáticamente `ACCOUNT_ID` y `AWS_REGION` con los GitHub Secrets antes de aplicar el manifiesto. Para una aplicación manual, reemplaza ambos valores por los datos reales de tu cuenta.

## Pipeline CI/CD

El workflow `.github/workflows/deploy-eks.yml` se ejecuta con cada push a la rama `master`.

```text
GitHub Actions → Build Docker → Push Amazon ECR → Deploy Amazon EKS
```

El pipeline:

1. Descarga el código.
2. Configura las credenciales de AWS.
3. Inicia sesión en Amazon ECR.
4. Construye y publica `frontend-devops:latest`.
5. Actualiza el kubeconfig del clúster EKS.
6. crea el namespace `devops` si no existe y aplica los manifiestos.
7. Reinicia el Deployment y espera que el rollout finalice correctamente.

El repositorio de ECR `frontend-devops` y el clúster EKS deben existir antes de ejecutar el workflow. El clúster también debe tener Metrics Server disponible para que el HPA pueda obtener métricas de CPU.

## GitHub Secrets

Configura estos secretos en el repositorio:

| Secret | Descripción |
|---|---|
| `AWS_ACCESS_KEY_ID` | Access key con permisos sobre ECR y EKS |
| `AWS_SECRET_ACCESS_KEY` | Secret key correspondiente |
| `AWS_REGION` | Región del repositorio ECR y del clúster EKS |
| `AWS_ACCOUNT_ID` | ID de la cuenta AWS |
| `EKS_CLUSTER_NAME` | Nombre del clúster EKS |

La identidad IAM usada por GitHub Actions necesita permisos para publicar imágenes en ECR, consultar el clúster EKS y estar autorizada para operar recursos Kubernetes en el clúster.

## Verificación

Después del despliegue:

```bash
kubectl get pods -n devops
kubectl get svc -n devops
kubectl get hpa -n devops
kubectl logs -n devops deployment/frontend-devops
```

Para obtener la URL pública, consulta la columna `EXTERNAL-IP` del Service:

```bash
kubectl get svc frontend-devops -n devops
```
