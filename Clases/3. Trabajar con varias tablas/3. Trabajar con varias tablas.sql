/* 3.1. JOINS */

SELECT
	ventas.ventas_id,
    ventas.Fecha,
    local.Direccion,
    ventas.clave_producto,
    ventas.venta,
    empleados.Nombre,
    empleados. Apellido
FROM ventas
JOIN local
	ON ventas.ID_local = local.ID_local
JOIN empleados
	ON ventas.venta_empleado = empleados.ID_empleado;

/* 3.2. JOINS a través de bases de datos*/

USE periodo;
SELECT
	periodo_1_id,
    Fecha,
    datos.empleados.Nombre,
    datos.empleados.Apellido,
    datos.local.Direccion,
    Turno_completo
FROM periodo_1
JOIN datos.empleados
	ON periodo_1.ID_empleado = datos.empleados.ID_empleado
JOIN datos.local
	ON periodo_1.Local = datos.local.Letra_zona;

/* 3.3. Self JOIN*/

USE datos;
SELECT * FROM empleados;

SELECT*
FROM empleados e
JOIN empleados p
	ON e.ID_Gerente = p.ID_empleado;
    
/* 3.4. JOINS externos*/

USE datos;
SELECT * FROM ventas
JOIN empleados
	ON ventas.venta_empleado = empleados.ID_empleado;

/* En este caso, se está saltando gente, es decir, en este caso, son empleados que no vendieron (TOMA LA INFORMACIÓN QUE EXISTE EN AMBAS TABLAS)*/

SELECT*
FROM ventas
RIGHT JOIN empleados
	ON ventas.venta_empleado = empleados.ID_empleado;

/* En este caso, un LEFT JOIN tomaría todos los valores de las ventas, y si no aparece nadie en la tabla de empleados,
 es que hay alguien que vendió que no está registrado en los empleados*/

SELECT * FROM ventas
LEFT JOIN empleados
	ON ventas.venta_empleado = empleados.ID_empleado;

/* 3.5. USING */

SELECT*
FROM ventas
JOIN local
	ON ventas.ID_local = local.ID_local;
    
/* USING se usa cuando se comparte el mismo nombre de columna */

SELECT*
FROM ventas
JOIN local
	USING(ID_local);
    
/* 3.6. CROSS JOIN */

SELECT * FROM productos
CROSS JOIN ingredientes;

/* 3.7. JOIN NATURAL */

SELECT*
FROM ventas
NATURAL JOIN local;

/* En este caso funciona muy bien porque en ambos casos hay el mismo nombre de columna, pero...*/

SELECT*
FROM ventas
NATURAL JOIN empleados;

/* En este caso, está haciendo básicamente un CROSS JOIN, porque a todas las ventas le puso todos los empleados */

/* 3.8. UNION */

/* Básicamente une dos consultas y al convierte en una */

SELECT producto FROM productos
UNION
SELECT ingredientes FROM ingredientes;

/* Sirve para anexar una tabla encima de otra, por ejemplo información mensual. No se puede tener diferente cantidad de columnas */