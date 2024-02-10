USE practicas;

SELECT
	clientes.Nombre AS Nombre_cliente,
    ventas.Venta
FROM ventas
JOIN clientes
	ON ventas.ID_cliente = clientes.ID_cliente;
    
SELECT
	ventas.venta,
    zona.zona
FROM ventas
JOIN zona
	ON ventas.ID_zona = zona.ID_zona;
    
SELECT
	ventas.venta,
    vendedor.Nombre,
    vendedor.Apellido
FROM ventas
JOIN vendedor
	ON ventas.ID_vendedor = vendedor.ID_vendedor;
    
SELECT
	ventas.venta,
    producto.producto
FROM ventas
JOIN producto
	ON ventas.ID_producto = producto.ID_producto;
    
    
/* ------------------ */

SELECT
	ventas.venta,
    vendedor.Nombre AS Nombre_vendedor,
    vendedor.Apellido AS Apellido_vendedor,
    clientes.Nombre AS Nombre_cliente
FROM ventas
JOIN vendedor
	ON ventas.ID_Vendedor = vendedor.ID_Vendedor
JOIN clientes
	ON ventas.ID_Cliente = clientes.ID_Cliente;
    
SELECT
	ventas.venta,
    clientes.Nombre AS Nombre_cliente,
    zona.zona,
    producto.producto
FROM ventas
JOIN clientes
	ON ventas.ID_cliente = clientes.ID_cliente
JOIN zona
	ON ventas.ID_zona = zona.ID_zona
JOIN producto
	ON ventas.ID_producto = producto.ID_producto;

/* --------------- */

SELECT*
FROM ventas
RIGHT JOIN vendedor
	ON ventas.ID_vendedor = vendedor.ID_vendedor
WHERE venta IS NULL;

/* ------------ */

SELECT
	ventas.venta,
    clientes.Nombre AS Nombre_cliente,
    zona.zona
FROM ventas
JOIN clientes
	USING (ID_cliente)
JOIN zona
	USING (ID_zona);
    
SELECT
	ventas.venta,
    vendedor.nombre AS Nombre_vendedor,
    producto.producto
FROM ventas
JOIN vendedor
	USING(ID_vendedor)
JOIN producto
	USING(ID_producto);
    
/*  ----------------- */
    
SELECT
	producto.producto AS Nombre_producto,
    clientes.Nombre AS Nombre_cliente
FROM producto
CROSS JOIN clientes;

/* La forma implícita de hacer esto es...*/

SELECT
	producto.producto AS Nombre_producto,
    clientes.Nombre AS Nombre_cliente
FROM producto, clientes;

/*  ----------------- */

SELECT
	clientes.Nombre AS Nombre_cliente,
    clientes.Clasificacion_credito
FROM clientes
WHERE Clasificacion_credito = "A"
UNION
SELECT
	clientes.Nombre AS Nombre_cliente,
    clientes.Clasificacion_credito
FROM clientes
WHERE Clasificacion_credito = "B";

SELECT
	vendedor.Nombre AS Nombre_vendedor
FROM vendedor
WHERE Estado_civil = "Casado" AND Edad > 50
UNION
SELECT
	vendedor.Nombre AS Nombre_vendedor
FROM vendedor
WHERE Estado_civil = "Soltero" AND Edad < 30;