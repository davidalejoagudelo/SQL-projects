/* 4.2. MODIFICAR FILA*/

SELECT*
FROM ingredientes;

INSERT INTO ingredientes(Ingredientes)
VALUES("Aceituna");

/* IMPORTANTE: Si lo anterior se vuelve a ejectuar, volverá a insertar esta columna*/

SELECT*
FROM ingredientes;

/* 4.3. MODIFICAR MULTIPLES FILAS*/

INSERT INTO ingredientes(ingredientes)
VALUES("Jamon"),("BBQ"),("J.Serrano");

SELECT*
FROM ingredientes;

/* Acá solo metimos en una sola columna, pero se puede haver con múltiples columnas, con arrays*/

INSERT INTO ingredientes(ingredientes, clave_ingrediente, precio_porcion)
VALUES("Manzana","mzn",5);

SELECT*
FROM ingredientes;

/* Pero si quiero meter múltiples filas completas */

INSERT INTO ingredientes(ingredientes, clave_ingrediente, precio_porcion)
VALUES("Champiñon","chm",8),("queso cabra","qc",20);

SELECT*
FROM ingredientes;

/* Si se eliminan datos, el id de los ingredientes que se borraron no se volverá a usar, por eso hay saltos... */

/* 4.4.MODIFICAR VARIAS TABLAS */

/* Hay tablas que están relacionadas entre si, básicamente comparten un KEY (por ejemplo ID_venta), y si se hace
una modificación en una tabla, esta también debería afectar la otra tabla.*/

SELECT*
FROM ventas;

INSERT INTO ventas(id_local,clave_producto,venta)
VALUES(2,"pzz",233);

SELECT last_insert_id();

INSERT INTO venta_detalle(ID_venta,Tipo)
VALUES (last_insert_id(),"Llevar");

SELECT*
FROM ventas;

/* 4.5. COPIAR UNA TABLA */

CREATE TABLE archivo_ventas AS
SELECT*
FROM ventas;

/* Vamos a Truncar la tabla en el esquema. Luego podemos hacer una copia de los datos de la tabla anterior, pero podemos poner condiciones... */

INSERT INTO archivo_ventas
SELECT*
FROM ventas
WHERE venta > 1000;

/* 4.6. MODIFICART FILAS */

SELECT*
FROM ingredientes;

/* En esta tabla, la palabra "PIÑA" puede generar inconvenientes */

UPDATE ingredientes
SET ingredientes = "pina", clave_ingrediente = "pin"
WHERE ingredientes_id = 5;

/* -------- */

/* Podría modificar las ventas de la tabla ventas. Esto puede ser peligroso, y aún no sabemos como revertir esto.*/

UPDATE ventas
SET venta = 777
WHERE id_local = 1;

/* 4.7. MODIFICAR CON SUBCONSULTAS */

SELECT*
FROM ventas;

/* Qué pasaría si quiero modificar cosas de los locales 3 y 4 */

SELECT ID_local
FROM local
WHERE letra_zona = "D";

UPDATE archivo_ventas
SET venta = venta*1.16
WHERE ID_local IN
		(SELECT ID_local 
        FROM local
        WHERE letra_zona IN("D","C"));
        
/* En lugar de usar el 4 de ID_loal, se hace con la letra de la zona que equivale a ese ID_local, la cual se encuentra en otra tabla */

SELECT ID_local 
FROM local
WHERE letra_zona IN("D","C");

/* 4.8. DELETE */

DELETE FROM ingredientes
WHERE ingredientes_id = 8;

DELETE FROM ingredientes
WHERE ingredientes_id BETWEEN 15 AND 17;
