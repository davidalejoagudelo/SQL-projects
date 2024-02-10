/* 5.1. AGREGACIONES */

USE datos;

SELECT*
FROM ventas;

SELECT
	MAX(venta) AS Venta_máxima,
    venta_empleado,
    fecha
FROM ventas;

SELECT
	SUM(venta) AS Total_ventas
FROM ventas;

/* Si acá le pidiera una fecha por ejemplo, no tendría sentido, porque las ventas son una suma de difewrentes fechas, entonces ¿Esa fecha que representa?
Suele dar la primera fecha de la tabla*/

SELECT
	SUM(venta) AS Total_ventas,
    fecha
FROM ventas;

SELECT*
FROM ventas;

SELECT COUNT(venta) AS Conteo_ventas
FROM ventas;

SELECT COUNT(Fecha) AS Fechas_totales
FROM ventas;

/* Acá solo dice que hay 22 fechas, porque hay un registro sin fecha, y COUNT() no tiene en cuenta los nulos */

SELECT
	COUNT(DISTINCT venta_empleado) AS Empleados_diferentes
FROM ventas;

/* Al ejecutar esto, básicamente estaría viendo el número de empleados que realizaron ventas, ya que no contará los repétidos */

SELECT AVG(venta)
FROM ventas;

/* 5.2. GROUP BY */

SELECT
	SUM(venta),
    ID_local
FROM ventas;

/* En este caso, si agrupo por locales, me dará la suma total de cada local */

SELECT
	SUM(venta) AS Total_ventas,
    ID_local
FROM ventas
GROUP BY ID_local;

SELECT
	SUM(venta),
    venta_empleado
FROM ventas
GROUP BY venta_empleado;

/* En este caso, si algún empleado no vendió, no saldrá en el query */

/* 5.3. HAVING */

/* Este es otro filtro, igual que WHERE, pero este se utiliza para filtrar datos agrupados, ya que WHERE no los toma */

SELECT
	ID_local,
    clave_producto,
    SUM(venta) AS venta_total
FROM ventas
WHERE venta_total > 1500
GROUP BY ID_local, clave_producto
ORDER BY ID_local DESC;

/* En este caso, WHERE no servirá porque venta total es una clausula inventada a partir de una agregación */

SELECT*
FROM ventas;

SELECT
	ID_local,
    clave_producto,
    SUM(venta) AS venta_total
FROM ventas
GROUP BY ID_local, clave_producto
HAVING venta_total > 1500
ORDER BY ID_local DESC;

/* 5.4. WITH ROLLUP */

SELECT
	ID_local,
    SUM(venta) AS venta_total
FROM ventas
GROUP BY ID_local;

/* WITH ROLLUP permite hacer una última fila donde se suma lo que se ha agrupado y agregado */

SELECT
	ID_local,
    SUM(venta) AS venta_total
FROM ventas
GROUP BY ID_local
WITH ROLLUP;

/* Se puede hcaer con múltiples agrupaciones */

SELECT
	ID_local,
    clave_producto,
    SUM(venta) AS venta_total
FROM ventas
GROUP BY ID_local, clave_producto
WITH ROLLUP;
    
/* En este caso, coloca una fila resumen despues de cada local. Es decir, de cada local, me está dando la suma de cada producto, y la suma total

NOTA: Esto trae problemas al exportarla para otros usos como su análisis en Excel, R, Power BI, etc, porque inserta una fila que no representa
nada de los datos */