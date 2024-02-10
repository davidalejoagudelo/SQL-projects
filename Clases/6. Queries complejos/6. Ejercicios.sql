-- 11.1 IN. Crear un subquery para generar una vista con:

-- 1. Los vendedores que no vendieron en 2018

USE practicas;

SELECT *
FROM vendedor ve
WHERE ID_vendedor NOT IN (
	SELECT
		ID_vendedor
    FROM ventas v
    WHERE Fecha_venta BETWEEN '2018-01-01' AND '2018-12-31');
    
-- 2. Productos que no se vendieron en marzo del 2017

SELECT *
FROM producto p
WHERE ID_producto NOT IN (
	SELECT
		ID_producto
    FROM ventas v
    WHERE Fecha_venta BETWEEN '2017-03-01' AND '2017-03-31'
);

-- 3. Clientes que compraron propiedad de remates bancarios en el primer cuarto de 2016

SELECT*
FROM clientes c
WHERE ID_cliente IN(
	SELECT 
		ID_cliente
    FROM ventas v
    WHERE ID_producto IN (
		SELECT ID_producto
        FROM producto
        WHERE Producto = 'Remates') AND Fecha_venta BETWEEN '2016-01-01' AND '2016-03-31')
ORDER BY ID_cliente;

-- 11.2 ALL y ANY. Generar una vista para entregar el informe que contenga

-- Todas las ventas superiores a la venta más cara de una oficina

SELECT *
FROM ventas
WHERE venta > ALL (
	SELECT 
		venta
	FROM ventas
    WHERE ID_producto = 2
);

-- Cualquier venta mayor a la de una oficina

SELECT *
FROM ventas
WHERE venta > ANY (
	SELECT
		venta
    FROM ventas
	WHERE ID_producto = 2
);

-- 11.2 EXISTS. Generar una vista para entregar el informe que contenga

-- Todos los vendedores que no han vendido nada

SELECT*
FROM vendedor ve
WHERE NOT EXISTS (
	SELECT*
    FROM ventas v
    WHERE ve.ID_vendedor = v.ID_vendedor
);

-- 11.3 SUBQUERY en SELECT

-- Obtener el % que representa cada venta del total por cliente

SELECT 
	ID_venta,
    ID_cliente,
    venta,
    (SELECT
		SUM(venta)
	FROM ventas ve
	WHERE ve.ID_cliente = v.ID_cliente
    ) AS Total_cliente,
    venta*100/(SELECT
		SUM(venta)
	FROM ventas
	WHERE ID_cliente = v.ID_cliente) AS Porcentaje
FROM ventas v;

SELECT
	SUM(venta)
FROM ventas
GROUP BY ID_cliente;