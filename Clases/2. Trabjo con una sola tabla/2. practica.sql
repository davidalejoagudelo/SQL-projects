USE practicas;
SELECT * FROM ventas;
SELECT ID_Zona, Venta, ID_Cliente FROM ventas;
SELECT Venta AS Ventas_nuevo_nombre FROM ventas;
SELECT venta*1.16 AS Venta_con_IVA FROM ventas;

SELECT * FROM ventas;
SELECT ID_zona,venta FROM ventas WHERE ID_zona = 2;
SELECT venta FROM ventas WHERE venta >2000000;
SELECT ID_cliente,ID_producto FROM ventas WHERE ID_cliente = 7;
SELECT venta FROM ventas WHERE venta < 1000000;

SELECT ID_zona, venta FROM ventas WHERE venta >=1500000 AND ID_zona = 2;
SELECT ID_zona, ID_vendedor, venta FROM ventas WHERE venta < 500000 AND ID_zona = 2 AND ID_vendedor = 2;
SELECT ID_vendedor, venta FROM ventas WHERE venta > 999999 OR ID_vendedor = 13;
SELECT ID_cliente, venta FROM ventas WHERE NOT ID_cliente = 10;

SELECT ID_zona,venta FROM ventas WHERE ID_zona IN (1,2,3,4) ORDER BY ID_zona DESC;
SELECT ID_Cliente, venta FROM ventas WHERE ID_Cliente IN (6,7,8,9);
SELECT ID_vendedor, venta FROM ventas WHERE NOT ID_vendedor IN (15, 21, 35);

SELECT * FROM vendedor;
SELECT Apellido FROM vendedor WHERE Apellido REGEXP("ez$");
SELECT Nombre, Apellido FROM vendedor WHERE Apellido REGEXP ("ez$");
SELECT Apellido FROM vendedor WHERE Apellido  REGEXP ("ez$|^sa");

SELECT * FROM clientes;
SELECT * FROM clientes WHERE Telefono IS NULL;

SELECT * FROM vendedor;
SELECT * FROM vendedor ORDER BY Nombre DESC;
SELECT * FROM vendedor ORDER BY Nombre, Apellido DESC;

SELECT * FROM ventas LIMIT 10;
SELECT * FROM ventas LIMIT 49,51;