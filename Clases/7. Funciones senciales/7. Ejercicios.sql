/* Ejercicios 1. string y fechas*/

-- 1. ¿Cuál es el nombre y apellido más largo de nuestros vendedores?

USE practicas;

SELECT*
FROM vendedor;

SELECT
    CONCAT(Nombre, " ", Apellido) AS Nombre_completo,
    LENGTH(CONCAT(Nombre, " ", Apellido)) AS Número_de_caracteres
FROM vendedor
ORDER BY Número_de_caracteres DESC
LIMIT 0,1;

-- 2. ¿Ventas totales para los últimos 3 años?

SELECT
	SUM(venta) AS Ventas_totales,
    YEAR(Fecha_venta)
FROM ventas
GROUP BY YEAR(Fecha_venta)
ORDER BY YEAR(Fecha_venta) DESC
LIMIT 0,3;

/* Ejercicios 2. IF */

-- 3. Crear una lista para dar seguimiento a las ventas mayores a $2.9 M en 2019

SELECT
	venta,
    YEAR(Fecha_venta) AS Año_venta,
	IF(venta>2900000, "Seguimiento", "Sin seguimiento") AS Seguimiento_venta
FROM ventas
WHERE YEAR(Fecha_venta) = "2019"
HAVING Seguimiento_venta = "Seguimiento"
ORDER BY venta DESC;
