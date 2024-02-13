/* 7.1. Funciones numéricas */

USE datos;

/* ROUND */

SELECT ROUND(2.4567,2);

/* TRUNCATE */
-- Quita decimales. No redondea, los quita

SELECT TRUNCATE(3.76621,1);

/* CEILING */

-- Siepre redondea para arriba. No importa que tan abajo esté el decimal

SELECT CEILING(2.1234123);

/* FLOOR */

-- Siempre redondea hacia abajo

SELECT FLOOR(2.73621);

/* ABS */

-- Devuelve el valor absoluto del número

SELECT ABS(-194.8284);

/* RAND */

-- Devuelve un número decimal aleatorio

SELECT RAND();

-- Si quiero un número entero de x digitos, debo multiplicarlo

SELECT RAND()*100;

-- Si quisiera un entero aleatoreo

SELECT TRUNCATE(RAND()*10,0) AS Aleatorio
HAVING Aleatorio BETWEEN 1 AND 10;

/* 7.2. Funciones de texto */

SELECT LENGTH("Ejemplo");

SELECT UPPER("Ejemplo");

SELECT LOWER("EJEMPLO");

SELECT LEFT("ejemplo",3);

SELECT RIGHT("ejemplo",3);

SELECT SUBSTRING("Ejemplo",2,4);

SELECT LOCATE("je","ejemplo");

SELECT REPLACE("Ejemplo","jemplo","xample");

SELECT CONCAT("Ejemplo"," ","SQL");

/* 7.2. Funciones de fechas */

SELECT NOW(); -- Da la hora y fecha exacta

SELECT CURDATE(); -- Da la fecha de hoy, sin la hora

SELECT CURTIME(); -- Hora actual. Current time

SELECT YEAR(NOW());

SELECT MONTH(NOW());

SELECT DAY(NOW());

SELECT HOUR(NOW()); -- SQL trabaja con horario militar

SELECT MINUTE(NOW());

SELECT SECOND(NOW());

-- Se pueden extraer los nombres de los meses

SELECT MONTHNAME(NOW());

-- También se puede usar la función EXTRAXCT para obtener el año, mes, día o lo que sea, de una fecha.

SELECT EXTRACT(MONTH FROM NOW());

/* 7.4. IF NULL y coalesce */

-- Sirven para lidiar con los NULL

SELECT*
FROM datos.empleados;

USE emleados;

SELECT*
FROM empleados;

SELECT
	nombre,
    IFNULL(ID_gerente,"Gerente") AS Nivel_gerencial
FROM empleados;

-- Se especifica dentro, primero la columna original, y luego el valor por el que se reemplazará el NULL.

SELECT
	nombre,
    COALESCE(ID_gerente,domicilio,Nombre,"Gerente") AS gerente_nuevo
FROM empleados;

-- Reemplaza el valor NULL por otro de la misma fila. El orden dentro del paréntesis es el orden de búsqueda, si hay otro NULL, pasa a la siguiente columna.

/* 7.5. Función IF */

SELECT
	Venta_empleado,
    venta,
	IF(venta > 1300, "Bono", "Sin bono") AS Bono
FROM ventas;

/* Dentro del paréntesis se pone primero la condición, después, una coma y se pone la consecuencia, 
y después, la consecuencia si no se cumple la condición. IF(Condición, consecuencia si se cumple la condición, 
consecuencia si no se cumple) */

/* 7.6. CASE */

-- Permite tenber varias condiciones. Es más importante que el IF!!!

SELECT*
FROM ventas;

SELECT*,
	CASE
		WHEN venta > 1300 THEN "Bono jugoso"
        WHEN venta > 1000 THEN "Bono normal"
        WHEN venta > 500 THEN "Bono chiquito"
        ELSE "Echale ganas"
	END AS Bono
FROM ventas;

-- Este tipo de columnas son temporales, es decir que no se pueden llamar depsués.
-- Se escribe de mayor a menor o de menor a mayor (Como en C++), de acuerdo a lo que se busque.
-- Si se hacen ">", se ordena de mayor a menor, y viceversa.



