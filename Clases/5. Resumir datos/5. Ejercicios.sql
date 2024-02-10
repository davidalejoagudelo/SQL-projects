/* Ejercicio - Resumir Datos */

/* 1. ¿Cuál cliente realizó la compra máxima en el año 2018? */

USE practicas;

SELECT*
FROM ventas;

SELECT*
FROM clientes;

SELECT
	v.ID_cliente,
    MAX(v.venta) AS 'Compra máxima 2018',
	c.Nombre
FROM ventas v
JOIN clientes c
	ON v.ID_cliente=c.ID_cliente
WHERE Fecha_venta BETWEEN "2018-01-01" AND "2018-12-31";

/* 2. ¿Cuál fue el pago menor recibido en el año 2018? */

SELECT*
FROM pagos;

SELECT
	MIN(pago) AS 'Pago menor 2018',
    ID_pago
FROM pagos
WHERE Fecha_pago BETWEEN "2018-01-01" AND "2018-12-31";

/* 3. ¿Cuántas ventas hubo en el 2do semestre del 2018? */

SELECT*
FROM ventas;

SELECT
	COUNT(venta) AS 'Número de ventas - 2do semestre 2018'
FROM ventas
WHERE Fecha_venta BETWEEN "2018-07-01" AND "2018-12-31";

/* Ejercicio - Resumir Datos 2 */

/* 1. Las ventas por vendedor */

SELECT*
FROM ventas;

SELECT*
FROM vendedor;

SELECT
	v.ID_vendedor,
    ve.Nombre,
    ve.Apellido,
    COUNT(v.venta) AS 'Número de ventas'
FROM ventas v
RIGHT JOIN vendedor ve
	USING (ID_vendedor)
GROUP BY ID_vendedor;

/* 2. Las ventas por producto */

SELECT*
FROM ventas;

SELECT*
FROM producto;

SELECT
	p.ID_producto,
    p.producto,
	COUNT(v.venta) AS 'Número de ventas'
FROM ventas v
RIGHT JOIN producto p
	USING (ID_producto)
GROUP BY ID_producto;

/* 3. Resumen de compras por cliente en 2017 */

SELECT*
FROM clientes;

SELECT*
FROM ventas;

SELECT
	c.ID_cliente,
    c.Nombre,
    COUNT(c.ID_cliente) AS 'Número de compras',
    SUM(v.venta) AS 'Total vendido'
FROM clientes c
JOIN ventas v
	USING(ID_cliente)
WHERE v.Fecha_venta BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY c.ID_cliente;

/* 4. Resumen de compras por cliente en 2017 que hayan sido mayores a 150000 */

SELECT*
FROM ventas;

SELECT*
FROM clientes;

SELECT
	c.Nombre,
    v.ID_cliente,
    SUM(v.venta) AS Compra_total
FROM ventas v
JOIN clientes c
	USING(ID_cliente)
WHERE v.Fecha_venta BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY ID_cliente
HAVING Compra_total > 150000;

/* 5. Lista de clientes morosos */

SELECT*
FROM ventas;

SELECT*
FROM pagos
WHERE ID_venta = 1;

SELECT*
FROM clientes;

SELECT
    ID_cliente,
    c.Nombre,
    v.venta,
    SUM(p.pago) AS pago,
    SUM(p.pago)-v.venta AS Diferencia
FROM ventas v
JOIN pagos p
	USING (ID_venta)
JOIN clientes c
	USING (ID_cliente)
GROUP BY ID_venta, ID_cliente
HAVING Diferencia <0;
    