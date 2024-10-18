https://dbdiagram.io/

Table autor {
  id integer [primary key, increment, not null]
  nombre varchar [not null]
  apellido1 varchar [not null]
  apellido2 varchar
  imagen varchar [not null]
  fecha_de_creacion timestamp [default: `now()`, not null]
}

Table proyecto {
  id integer [primary key, increment, not null]
  autor_id integer [ref: > autor.id, not null]
  idioma varchar [not null]
  video varchar
  web varchar
  ruc varchar
}

Table participaciones{
  id_proyecto integer  [ref: > proyecto.id, not null]
  año datetime  [not null]
  descripcion_es varchar [not null]
  descripcion_gl varchar [not null]
  resultado_es varchar [not null]
  resultado_gl varchar [not null]
}

Table imagenes{
  url varchar [primary key, not null]
  id_proyecto integer  [ref: > proyecto.id, not null]
  alt_text_es varchar
  alt_text_gl varchar
}

Table traducciones{
  id_proyecto integer  [ref: > proyecto.id, not null]
  titulo_es varchar [not null]
  titulo_gl varchar [not null]
  resumen_es varchar [not null]
  resumen_gl varchar [not null]
}

### Conversión de DBML a Script SQL para PostgreSQL

Aquí está el script SQL para crear las tablas de tu esquema, basado en la descripción que has dado:

```sql
-- Table: autor
CREATE TABLE autor (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    apellido1 VARCHAR NOT NULL,
    apellido2 VARCHAR,
    imagen VARCHAR NOT NULL,
    fecha_de_creacion TIMESTAMP DEFAULT now() NOT NULL
);

-- Table: proyecto
CREATE TABLE proyecto (
    id SERIAL PRIMARY KEY,
    autor_id INTEGER NOT NULL REFERENCES autor(id),
    idioma VARCHAR NOT NULL,
    video VARCHAR,
    web VARCHAR,
    ruc VARCHAR
);

-- Table: participaciones
CREATE TABLE participaciones (
    id_proyecto INTEGER NOT NULL REFERENCES proyecto(id),
    año DATE NOT NULL,
    descripcion_es VARCHAR NOT NULL,
    descripcion_gl VARCHAR NOT NULL,
    resultado_es VARCHAR NOT NULL,
    resultado_gl VARCHAR NOT NULL,
    PRIMARY KEY (id_proyecto, año) -- Uso de (id_proyecto, año) como clave primaria
);

-- Table: imagenes
CREATE TABLE imagenes (
    url VARCHAR PRIMARY KEY,
    id_proyecto INTEGER NOT NULL REFERENCES proyecto(id),
    alt_text_es VARCHAR,
    alt_text_gl VARCHAR
);

-- Table: traducciones
CREATE TABLE traducciones (
    id_proyecto INTEGER NOT NULL REFERENCES proyecto(id),
    titulo_es VARCHAR NOT NULL,
    titulo_gl VARCHAR NOT NULL,
    resumen_es VARCHAR NOT NULL,
    resumen_gl VARCHAR NOT NULL,
    PRIMARY KEY (id_proyecto)
);
```

### Dockerfile para PostgreSQL

A continuación, creamos un `Dockerfile` que configura un contenedor de PostgreSQL y ejecuta el script SQL al iniciar:

1. Crea un archivo `Dockerfile`:

```Dockerfile
# Usa la imagen oficial de PostgreSQL
FROM postgres:15

# Establece una variable de entorno para la contraseña del usuario "postgres"
ENV POSTGRES_PASSWORD=mysecretpassword

# Copia el archivo SQL en la carpeta de inicialización de Docker de PostgreSQL
COPY init.sql /docker-entrypoint-initdb.d/
```

2. Crea un archivo `init.sql` que contiene el script SQL que creará las tablas en la base de datos:

Este archivo es el script que te generé antes, simplemente guárdalo como `init.sql`.

3. Docker Compose para configurar el puerto y la base de datos:

A continuación, creamos un archivo `docker-compose.yml` para automatizar la creación del contenedor y exponer el puerto 5432 para realizar consultas.

```yaml
version: '3.8'
services:
  db:
    image: postgres:15
    container_name: my_postgres_db
    environment:
      POSTGRES_PASSWORD: mysecretpassword
      POSTGRES_USER: myuser
      POSTGRES_DB: mydatabase
    ports:
      - "5432:5432"
    volumes:
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
```

### Pasos para ejecutar:

1. Guarda el archivo `Dockerfile` en una carpeta.
2. Crea el archivo `init.sql` en la misma carpeta con el contenido del script SQL.
3. Guarda el archivo `docker-compose.yml` en la misma carpeta.
4. Ejecuta los siguientes comandos en esa carpeta:

```bash
docker-compose up
```

Esto iniciará un contenedor de PostgreSQL con las tablas definidas en el script, exponiendo el puerto `5432` para que puedas conectarte desde tu sistema local.

### Conexión a la base de datos:

Una vez que el contenedor esté en funcionamiento, puedes conectarte a la base de datos con cualquier cliente PostgreSQL (como `psql` o PgAdmin) usando los siguientes datos de conexión:

- **Host**: `localhost`
- **Puerto**: `5432`
- **Usuario**: `myuser`
- **Contraseña**: `mysecretpassword`
- **Base de datos**: `mydatabase`

De esta manera, tendrás un contenedor Docker que crea automáticamente las tablas en una base de datos PostgreSQL y expone el puerto para realizar consultas.




-- Insertar un registro en la tabla autor
INSERT INTO autor (nombre, apellido1, apellido2, imagen, fecha_de_creacion) 
VALUES ('Juan', 'Pérez', 'Gómez', 'imagen1.jpg', now());

-- Insertar un registro en la tabla proyecto
INSERT INTO proyecto (autor_id, idioma, video, web, ruc) 
VALUES (1, 'Español', 'video1.mp4', 'http://ejemplo.com', '123456789');

-- Insertar un registro en la tabla participaciones
INSERT INTO participaciones (id_proyecto, año, descripcion_es, descripcion_gl, resultado_es, resultado_gl) 
VALUES (1, '2024-10-18', 'Participación en evento cultural', 'Participación en evento kulturel', 'Exitoso', 'Arrakasta');

-- Insertar un registro en la tabla imagenes
INSERT INTO imagenes (url, id_proyecto, alt_text_es, alt_text_gl) 
VALUES ('http://ejemplo.com/imagen1.jpg', 1, 'Descripción de imagen en español', 'Deskripzioa irudiaren glotziz');

-- Insertar un registro en la tabla traducciones
INSERT INTO traducciones (id_proyecto, titulo_es, titulo_gl, resumen_es, resumen_gl) 
VALUES (1, 'Título en español', 'Izenburua glotziz', 'Resumen en español', 'Laburpena glotziz');
