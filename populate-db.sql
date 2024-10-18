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
