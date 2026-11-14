# Backend Vestistock

API REST desarrollada con Node.js y Express para el proyecto Vestistock. El backend se conecta a PostgreSQL y MongoDB, y ofrece un endpoint de salud para comprobar la disponibilidad de la API y de ambas bases de datos.

## Tecnologías

- **Node.js**: entorno de ejecución de JavaScript.
- **Express 5**: servidor y enrutamiento HTTP.
- **PostgreSQL**, mediante el paquete `pg`: conexión con pool de clientes.
- **MongoDB**, mediante **Mongoose**: conexión y gestión del cliente de base de datos.
- **dotenv**: carga de configuración desde variables de entorno.
- **CORS**: habilitación de solicitudes entre distintos orígenes.
- **Morgan**: registro de solicitudes HTTP durante el desarrollo.

## Requisitos previos

- Node.js compatible con la versión de Mongoose incluida en el proyecto y npm.
- Una instancia accesible de PostgreSQL.
- Una instancia accesible de MongoDB, local o alojada (por ejemplo, MongoDB Atlas).
- Las credenciales y los datos de conexión de ambas bases de datos.

## Instalación y ejecución

1. Clona el repositorio y entra en la carpeta del proyecto:

   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd backend-vestistock
   ```

2. Instala las dependencias:

   ```bash
   npm install
   ```

3. Crea un archivo `.env.example` en la raíz del proyecto. Puedes partir de esta plantilla y reemplazar los valores por los de tu entorno:

   ```dotenv
   PORT=3000
   PG_DATABASE=vestistock
   MONGO_URI=mongodb://localhost:27017/vestistock
   ```

   Para MongoDB Atlas, asigna a `MONGO_URI` la URI de conexión proporcionada por Atlas. Asegúrate de que el nombre de la base de datos corresponda al que quieres utilizar. No compartas ni subas el archivo `.env.example`: está excluido de Git.

4. Comprueba que las instancias de PostgreSQL y MongoDB estén en ejecución y sean accesibles con los datos configurados.

5. Inicia el servidor en modo desarrollo, con reinicio automático al cambiar archivos:

   ```bash
   npm run dev
   ```

   Para iniciar el servidor normalmente:

   ```bash
   npm start
   ```

Por defecto, la API escucha en `http://localhost:3000`. Puedes cambiar el puerto con la variable `PORT`.

## Endpoint de salud

Envía una solicitud `GET` a:

```text
http://localhost:3000/api/health
```

La respuesta informa el estado de la API, PostgreSQL y MongoDB, e incluye la latencia de las comprobaciones. Devuelve HTTP `200` cuando los servicios están saludables y HTTP `503` si alguna de las bases de datos no está disponible. Hay una solicitud de ejemplo en `base/api_health.yml`.

## Estructura del proyecto

```text
backend-vestistock/
├── base/
│   └── api_health.yml        # Solicitud HTTP de ejemplo para el endpoint de salud
├── src/
│   ├── config/
│   │   ├── db.js             # Pools, conexiones y cierre de PostgreSQL y MongoDB
│   │   └── environment.js    # Variables de entorno y valores de configuración
│   ├── controllers/
│   │   └── healthController.js # Comprobación de estado y latencia de servicios
│   ├── routes/
│   │   └── healthRoutes.js   # Ruta GET /api/health
│   ├── app.js                # Configuración de Express, middlewares y rutas
│   └── server.js             # Arranque del servidor y cierre ordenado
├── .env                      # Configuración local (no se versiona)
├── package.json              # Dependencias y comandos npm
└── package-lock.json         # Versiones bloqueadas de dependencias
```

## Comandos disponibles

- `npm run dev`: inicia el servidor con `node --watch`.
- `npm start`: inicia el servidor con Node.js.

## Integrantes del equipo 
- Jorge David Devia Pipicano
- Jose Islen Morales Calderon 