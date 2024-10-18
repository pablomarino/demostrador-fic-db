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
