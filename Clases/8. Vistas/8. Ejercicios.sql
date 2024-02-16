/* 1. Crea una vista de clientes morosos al día de hoy */

USE practicas;

SELECT*
FROM ventas v
LEFT JOIN pagos p
	ON (p.ID_venta = v.ID_venta)
LEFT JOIN clientes c
	ON (v.ID_cliente = c.ID_cliente);

CREATE OR REPLACE VIEW clientes_morosos AS
SELECT
	v.ID_venta,
    c.Nombre,
	v.venta,
    SUM(p.Pago) AS Pago_total,
    v.venta-SUM(Pago) AS valor_a_pagar
FROM ventas v
LEFT JOIN pagos p
USING(ID_venta)
LEFT JOIN clientes c
USING(ID_cliente)
GROUP BY ID_venta
HAVING valor_a_pagar > 0
ORDER BY Nombre, valor_a_pagar DESC;

SELECT *
FROM clientes_morosos;

/* 2. Crea una vista para los vonos de 2019 por ventas a los vendedores. Bono del 1% sobre lo vendido */

CREATE OR REPLACE VIEW Bono_2019 AS
SELECT
	ve.ID_vendedor,
    CONCAT(ve.Nombre,' ', ve.Apellido) AS Nombre_vendedor,
    SUM(v.venta) AS venta_total_2019,
    SUM(v.venta)*0.01 AS Valor_bono
FROM ventas v
JOIN vendedor ve
USING (ID_vendedor)
WHERE YEAR(v.Fecha_venta) = 2019
GROUP BY ID_vendedor
ORDER BY Valor_bono DESC;

SELECT *
FROM Bono_2019;