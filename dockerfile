# Usa la imagen oficial de PostgreSQL
FROM postgres:15

# Establece una variable de entorno para la contraseña del usuario "postgres"
ENV POSTGRES_PASSWORD=mysecretpassword

# Copia el archivo SQL en la carpeta de inicialización de Docker de PostgreSQL
COPY init.sql /docker-entrypoint-initdb.d/