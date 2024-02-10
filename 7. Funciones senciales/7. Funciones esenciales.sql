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
