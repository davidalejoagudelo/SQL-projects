/* STORE PROCEDURE */

-- 1. Crear un procedimiento con parámetros para obtener las ventas totales por producto

USE practicas;

SELECT*
FROM ventas;

SELECT
	MAX(LENGTH(Producto))
FROM producto;

-- Aca determiné mi máxima longitud del nombre del producto, para definir mi parámetro.

DROP PROCEDURE IF EXISTS sp_ventas_totales; -- Esto por si necesito editar un proceso almacenado. Debo eliminarlo primero. Para hacerlo con código
DELIMITER $$
CREATE PROCEDURE sp_ventas_totales (parametro_producto VARCHAR(11))
BEGIN
	SELECT
		p.Producto,
        sum(Venta) AS Suma_venta
    FROM ventas v
    JOIN producto p
		USING(ID_producto)
	WHERE parametro_producto = p.Producto
	GROUP BY p.Producto;
END$$
DELIMITER ;

CALL sp_ventas_totales("Consultorio");
CALL sp_ventas_totales("Oficina");

-- 2. Crear un procedimiento con parámetros para obtener el total de ventas por año por cliente

SELECT
	MAX(LENGTH(Nombre))
FROM clientes;

DROP PROCEDURE IF EXISTS sp_total_ventas_cliente_año;

DELIMITER $$
CREATE PROCEDURE sp_total_ventas_cliente_año (parametro_año INT, parametro_cliente VARCHAR(19))
BEGIN
	SELECT
		YEAR(v.Fecha_venta) AS Año,
        c.Nombre AS Nombre_cliente,
        SUM(v.venta) AS Ventas_totales
	FROM ventas v
    JOIN clientes c
		ON v.ID_cliente = c.ID_cliente
	WHERE YEAR(v.Fecha_venta) = parametro_año AND c.Nombre = parametro_cliente
    GROUP BY c.Nombre;
END $$
DELIMITER ;

CALL sp_total_ventas_cliente_año(2019, "Mart B & C");
CALL sp_total_ventas_cliente_año(2019, "Bienes de Occidente"); -- Mejor utilizar el ID del ciente como parámetro

DROP PROCEDURE IF EXISTS sp_total_ventas_IDcliente_año;

DELIMITER $$
CREATE PROCEDURE sp_total_ventas_IDcliente_año(parametro_año INT, parametro_cliente INT)
BEGIN
	SELECT
		YEAR(v.Fecha_venta) AS Año,
        c.Nombre AS Nombre_cliente,
        SUM(Venta) AS Ventas_totales
	FROM ventas v
    JOIN clientes c
		ON v.ID_cliente = c.ID_cliente
	WHERE YEAR(v.Fecha_venta) = parametro_año AND parametro_cliente = v.ID_cliente
    GROUP BY c.Nombre;
END $$
DELIMITER ;

CALL sp_total_ventas_IDcliente_año(2019, 2);