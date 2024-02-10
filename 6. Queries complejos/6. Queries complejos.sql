/* 6.1. SUBCONSULTAS */

USE datos;

SELECT*
FROM empleados
WHERE Edad > 25;

/* Por ejemplo, los empleados cuya edad es mayor al promedio de todos los empleados */

SELECT*
FROM empleados
WHERE Edad > (
	SELECT
		AVG(edad)
	FROM empleados);
	
/* Acá, hice primero una consulta donde determino el promedio de edad de los empleados, y esta determinar los empleados que se van an mostrar */

/* 6.2. OPERADOR IN */

/* Ej: ver empleados que SI vendieron algo */

SELECT
	COUNT(DISTINCT ID_empleado)
FROM empleados;

-- Acá veo que hay 11 empleados en la empresa

SELECT
	COUNT(DISTINCT venta_empleado)
FROM ventas;

-- Acá veo que en la tabla de ventas, solo hay 9 empleados, de 11 que hay

SELECT*
FROM empleados
WHERE ID_empleado IN(
	SELECT DISTINCT venta_empleado
    FROM ventas);

-- Lo que hay dentro de la subconsulta, es una lista de los códigos de los empleados, sin que se repitan, para eso es el DISTINCT

SELECT DISTINCT venta_empleado
FROM ventas;

-- Con el where no se puede usar el NOT IN, no funicona.

/* 6.3. JOIN VS. SUBQUERY */

SELECT*
FROM empleados e
LEFT JOIN ventas v
	ON e.ID_empleado = v.venta_empleado
WHERE ventas_id IS NULL;

/* 6.4. ALL */

SELECT
	v.venta
FROM ventas v
WHERE id_local=2;

SELECT*
FROM ventas
WHERE venta > (
	SELECT
		MAX(venta)
	FROM ventas
    WHERE id_local = 2);
    
/* Acá, la subconsulta determina la máxima venta de local 2, y luego, esto permite determinar los 
datos del local que tuvo mayores ventas que la máxima venta del local 2 */

/* Estyo mismo se puede hacer con ALL */

SELECT*
FROM ventas
WHERE venta > ALL(
	SELECT venta
    FROM ventas
    WHERE id_local = 2
);

-- En este caso, SQL sabe que necesita encontrar el valor mayor a todas las ventas de mi subconsulta

SELECT
	v.venta
FROM ventas v
WHERE id_local=4;

SELECT*
FROM ventas
WHERE venta < ALL(
	SELECT venta
    FROM ventas
    WHERE id_local=4
);

-- Acá determinamos las ventas menores a todas las ventas de local 4, que sería el mínimo. Es lo mismo que...

SELECT*
FROM ventas
WHERE venta < (
	SELECT MIN(venta)
    FROM ventas
    WHERE id_local = 4
);

/* 6.5. ANY */

SELECT*
FROM ventas
WHERE venta > ANY (
	SELECT venta
    FROM ventas
    WHERE id_local = 2
);

/* Podría decirse que es comparar con el operador opuesto al ALL, es decir, a > ALL es igual a buscar un dato mayor que el dato más grande, 
pero a > ANY es buscar el dato mayor al valor más pequeño */

/* 6.6. QUERIS CORRELACIONADAS */

-- ¿Cuáles ventas de cada local fueron mayores al promedio de ese local

SELECT
	ID_local,
	AVG(venta) AS prom
FROM ventas
GROUP BY ID_local;

SELECT *
FROM ventas v
WHERE venta > (
	SELECT
		AVG(venta) AS prom
    FROM ventas
    WHERE ID_local=v.ID_local -- con esto, hago que para cada ID_local, se determine su propio promedio
)
ORDER BY ID_local;

/* 6.7. EXISTS */

SELECT*
FROM empleados
WHERE ID_empleado IN(
	SELECT
		DISTINCT venta_empleado
    FROM ventas);
    
-- Esto funciona porque la subconsulta daba una lista de los empleados en la tabla de ventas. Exist permite hacer más o meno slo mismo

SELECT *
FROM empleados e
WHERE EXISTS(
	SELECT venta_empleado
    FROM ventas
    WHERE venta_empleado = e.ID_empleado
		);
	
/* 6.8. Consultas dentro del SELECT */

-- Si declaro una columna dentro del SELECT, no puedo declarar esta columna para operar, debo usar un SELECT y escribir esa columna

SELECT
	ventas_id,
    venta,
    (SELECT
		AVG(venta)
    FROM ventas) AS promedio,
    venta - (SELECT promedio) AS diferencia
FROM ventas
ORDER BY venta DESC;

/* 6.8. Consultas dentro del FROM */

SELECT *
FROM (
	SELECT
		ventas_id,
        venta,
        (SELECT
			AVG(venta)
		FROM ventas) AS promedio,
		venta - (SELECT promedio) AS diferencia
	FROM ventas) AS tabla
WHERE diferencia > 100;