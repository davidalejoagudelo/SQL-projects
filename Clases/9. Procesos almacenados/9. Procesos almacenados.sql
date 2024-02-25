/* 9.2. Crear procesos almacenados */

USE datos;

SELECT*
FROM ventas
WHERE clave_producto = "pzz";

-- Si necesitara esta tabla todos los días, lo mejor es crear un proceso almacenado
-- Se usa DEIMITER para definir el final del proceso almacenado. La consulta termina con ;, y el proceso termina con $$

DELIMITER $$
CREATE PROCEDURE sp_pizza() -- sp = stored procedure
BEGIN
	SELECT*
	FROM ventas
	WHERE clave_producto = "pzz";
END $$
DELIMITER ;
-- Ahora, en el esquema está el proceso almacenado

CALL sp_pizza(); -- Con esto se llama un proceso almacenado creado anteriormente

-- ¿Cuál es la diferencia entre un proceso almacenado y una vista? El sp es más amplio, permite hacer cambios en una tabla, automatizar consultas, etc

/* 9.3. Crear procesos almacenados desde el wrkbench */

CALL sp_ventas_clz(); -- En este caso, como no hay parámetros, no son necesarios los parámetros

/* 9.4. Borrar procesos almacenados */

-- Se pueden en el workbench, o con codigo

DROP PROCEDURE sp_pizza;

/* 9.5. Parámetros */

DELIMITER $$
CREATE PROCEDURE sp_venta_producto (producto VARCHAR(3))
BEGIN
	SELECT *
    FROM ventas
    WHERE clave_producto = producto;
END $$
DELIMITER ;

CALL sp_venta_producto('pzz',1);

/* 9.6. Parámetros Default */

CALL sp_venta_producto(); -- Esto devuelve un error ya que se debían definir parámetros

CALL sp_venta_producto(NULL, NULL); -- Esto crea una tabla vacía.

-- Se puede definir una condición donde al no pner un parámetro, utlice un parámetro default

DELIMITER $$
CREATE PROCEDURE sp_venta_producto (producto VARCHAR(3), local_usuario INT(1))
BEGIN
	SELECT *
    FROM ventas
    WHERE clave_producto = IFNULL(producto, clave_producto) AND ID_local = IFNULL(local_usuario, ID_local);
END $$
DELIMITER ;

-- Con la función IF... IS NULL THEN... se puede definir un parámetro que no se NULL por default

CALL sp_venta_producto('pzz',1);

/* 9.7. Validación de parámetros */

