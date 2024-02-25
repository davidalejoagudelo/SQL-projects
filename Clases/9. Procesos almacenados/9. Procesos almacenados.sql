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
-- Entre el BEGIN y el END se debe colocar ";" para terminar la consulta

CALL sp_pizza(); -- Con esto se llama un proceso almacenado creado anteriormente

-- ¿Cuál es la diferencia entre un proceso almacenado y una vista? El sp es más amplio, permite hacer cambios en una tabla, automatizar consultas, etc

/* 9.3. Crear procesos almacenados desde el wrkbench */

CALL sp_ventas_clz(); -- En este caso, como no hay parámetros, no son necesarios los parámetros

/* 9.4. Borrar procesos almacenados */

-- Se pueden en el workbench, o con codigo

DROP PROCEDURE sp_pizza;

/* 9.5. Parámetros */

DELIMITER $$
CREATE PROCEDURE sp_venta_producto (producto VARCHAR(3), local_venta INT(1))
BEGIN
	SELECT *
    FROM ventas
    WHERE clave_producto = producto AND ID_local = local_venta;
END $$
DELIMITER ;

CALL sp_venta_producto('pzz', 1);

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

CALL sp_venta_producto(NULL,NULL); -- Esto muestra TODA la tabla

/* 9.7. Validación de parámetros */

DELIMITER $$
CREATE PROCEDURE actualizar_empleado(parametro_empleado VARCHAR(7), parametro_edad TINYINT, parametro_telefono VARCHAR(8))
BEGIN
	UPDATE empleados e
    SET
		e.edad = parametro_edad,
        e.telefono = parametro_telefono
    WHERE ID_empleado = parametro_empleado;
END $$
DELIMITER ;

CALL actualizar_empleado("1111222", 63, "01234567"); -- Esto actualizó la información del empleado

-- Se pueden poner restricciones a los parámetros de actualización

DELIMITER $$
CREATE PROCEDURE actualizar_empleado(parametro_empleado VARCHAR(7), parametro_edad TINYINT, parametro_telefono VARCHAR(8))
BEGIN
	IF parametro_edad < 18 OR parametro_edad > 60 THEN
		SIGNAL SQLSTATE "22003" -- Hay una lista de todos los SQLSTATE. Se usa para que avise en la consola
        SET MESSAGE_TEXT = "Edad fuera del rango";
	END IF;
	UPDATE empleados e
    SET
		e.edad = parametro_edad,
        e.telefono = parametro_telefono
    WHERE ID_empleado = parametro_empleado;
END $$
DELIMITER ;

CALL actualizar_empleado("1111222", 59, "01234567"); -- Esto actualizó la información del empleado

/* 9.8. Parámetros de salida */

DELIMITER $$
CREATE PROCEDURE sp_ventas_local (IN parametro_local_id INT, OUT parametro_suma_venta INT)
BEGIN
	SELECT
		ID_local,
        SUM(venta)
	INTO
		parametro_local_id,
        parametro_suma_venta
	FROM ventas
    WHERE ID_local = parametro_local_id;
END$$
DELIMITER ;

-- Dentro del INTO estoy declarando que el SELECT se haga dentro de los parámetros seleccionados.
-- Puede verse redundante, pero afuera solo se definen los parámetros, pero dentro, estos deben ser aclarados para SQL

CALL sp_ventas_local(1,0); -- Esto me da un error

-- Para que un proceso almacenado de una respuesta, hay que tener declarada una variable

SET @param_local;
SET @suma_ventas;

-- Lo anterior no se puede ejecutar. Para declarar una variable, hay que asignarle un valor inicial

SET @param_local = 1;
SET @suma_ventas = 0; -- NOTA: Estas variables solo existen dentro del ambiente de trabajo, no existen en otros ambientes y sesiones

CALL sp_ventas_local(@param_local,@suma_ventas);

-- Ya se pudo ejecutar

SELECT @suma_ventas;

-- Esto complica las cosas, poque si se quiere ver otro local, hay que ejecutar la varable, luego el proceso almacenado, y luego de nuevo la variable

/* 9.9. Variables */

SELECT
	SUM(venta)/COUNT(*)*1.10
FROM ventas;

DELIMITER $$

CREATE PROCEDURE sp_proceso_mejora_continua()
BEGIN
	DECLARE factor_mejora DECIMAL(9,1) DEFAULT 0; -- Cuando no se especifica nada, valdrá 0. Si no se coloca el DEFAULT, valdrá NULL
    DECLARE ventas_conteo INT;
    DECLARE ventas_totales DECIMAL(9,1) DEFAULT 0;
    
    SELECT
		COUNT(*),
        SUM(venta)
	INTO
		ventas_conteo,
        ventas_totales
	FROM ventas;
    
    SET factor_mejora = ventas_totales/ventas_conteo*1.10;
    
    SELECT factor_mejora;
END $$

DELIMITER ;

CALL sp_proceso_mejora_continua();

-- Esto me dice que necesito una venta promedio de 1054.

/* 9.9. Funciones */

SELECT*
FROM ventas;

-- Vamos a calcular el proceso de mejora continua de cada empleado, en un 10%

SELECT
	venta_empleado,
    ROUND(AVG(venta)*1.10,2) AS venta_promedio_mejora
FROM ventas
GROUP BY venta_empleado
ORDER BY venta_empleado DESC;

-- Ahora, hagamoslo pero con una función

DELIMITER $$
CREATE FUNCTION fn_mejora_empleado (parametro_empleado VARCHAR(7))
RETURNS INTEGER
READS SQL DATA -- Esto es un atributo. Mínimo 1, pero puede tener más
BEGIN
	DECLARE factor_mejora_continua DECIMAL(9,1) DEFAULT 0;
    DECLARE ventas_conteo INT;
    DECLARE ventas_total DECIMAL(9,1);
    
    SELECT
		COUNT(*),
        SUM(venta)
	INTO
		ventas_conteo,
        ventas_total
	FROM ventas
    WHERE venta_empleado = parametro_empleado;
    
    SET factor_mejora_continua = ventas_total/ventas_conteo*1.10;
    
RETURN factor_mejora_continua; -- Siempre deve tener un RETURN (como C++)
END$$
DELIMITER ;

-- Acá no se usa CALL, las funciones se pueden incluir dentro del SELECT

SELECT
	ID_empleado,
    nombre,
    fn_mejora_empleado(ID_empleado) AS venta_promedio_mejora
FROM empleados
ORDER BY ID_empleado DESC;
    