USE datos;

/* 8.1. Vistas */

SELECT
	l.letra_zona,
    l.telefono,
    v.venta,
    v.venta_empleado,
    e.nombre
FROM local l
LEFT JOIN ventas v
	ON(l.ID_local = v.id_local)
LEFT JOIN empleados e
	ON(v.venta_empleado = e.ID_empleado);
    
-- Si quisiera consultar esto otra vez, debería hacerlo todo nuevamente. Podemos convertirla en vista

CREATE VIEW venta_empleados AS
SELECT
	l.letra_zona,
    l.telefono,
    v.venta,
    v.venta_empleado,
    e.nombre
FROM local l
LEFT JOIN ventas v
	ON(l.ID_local = v.id_local)
LEFT JOIN empleados e
	ON(v.venta_empleado = e.ID_empleado);
    
-- Se cre+o la vista exitosamente. Refrescar los esquemas

SELECT*
FROM venta_empleados;

/* 8.2. Modificar y borrar vistas con código */

DROP VIEW venta_empleados; -- Para eliminar todo

-- Podemos modificar la vista, para añadir filtros u otrasa cosas.

CREATE OR REPLACE VIEW venta_empleados AS
SELECT
	l.letra_zona,
    l.telefono,
    v.venta,
    v.venta_empleado,
    e.nombre
FROM local l
LEFT JOIN ventas v
	ON(l.ID_local = v.id_local)
LEFT JOIN empleados e
	ON(v.venta_empleado = e.ID_empleado)
WHERE venta >1000;

SELECT*
FROM venta_empleados;

/* 8.2. Modificar vistas */

CREATE VIEW ventas_mayores_800 AS
SELECT*
FROM ventas
WHERE venta > 800;

SELECT*
FROM ventas_mayores_800;

SELECT*
FROM ventas;

DELETE FROM ventas_mayores_800
WHERE venta > 1000;

-- SQL elimina de la tabla original, todo lo que se borra en una vista. CUIDADO