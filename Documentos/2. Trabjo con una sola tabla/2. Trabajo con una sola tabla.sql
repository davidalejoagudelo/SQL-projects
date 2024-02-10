/* 2.1. USE, FROM Y SELECT*/

USE datos;
SELECT * FROM empleados;
SELECT * FROM ventas;
SELECT * FROM productos;

/* 	Se pueden seleccionar columnas específicas de una tabla, especificando la columna */

SELECT venta FROM ventas;

/* Si quiero seleccionar varias columnas, uso la "," despues del SELECT y escribo las columnas*/

SELECT venta,Fecha FROM ventas;

/* Se pueden hacer calculos y cambiar los nombres*/

SELECT venta, fecha,venta*0.19 AS IVA_cobrado FROM ventas; /* Acá incertamos una columna que es el iva, y le cambiamos el nombre con "AS"*/

/* Esto solo existe en SQL mientras se hace la consulta, no se altera la base de datos original, y si se exporta, SI guardará esta columna*/

/* 2.2. WHERE */
/* Se usa como un filtro */

SELECT * FROM ventas WHERE ID_local = 2;

/* Igual que en matemáticas, se pueden usar varios símbolos. "!=" es el símbolo "diferente de"*/

SELECT * FROM ventas WHERE venta <= 1000;

SELECT * FROM ventas WHERE ID_local !=2;

/* No se puede filtrar con base en una columna creada que no está en la BD original. Con querys si se puede*/

SELECT *,venta*0.19 AS IVA FROM ventas WHERE IVA < 150;

/* 2.3. AND, OR, NOT */

/* Estas se usan para hacer más acciones con WHERE*/

SELECT * FROM ventas WHERE ID_local = 2 AND clave_producto = "pzz";

SELECT * FROM ventas WHERE ID_local = 2 OR clave_producto = "pzz";

SELECT * FROM ventas WHERE ID_local =2 OR ID_local = 4;

SELECT * FROM ventas WHERE clave_producto != "pzz";

/* Usar != es lo mismo que usar NOT. Este sirve para negar varias otras expresiones. El NOT solo niega la clausula
que está después de el. Si por eujemplo ponemos un AND, eso no lo negará*/

SELECT * FROM ventas WHERE NOT clave_producto = "pzz" AND ID_local = 2;

/* Si quiero negar dos cosas, debo poner el not otra vez*/

SELECT * FROM ventas WHERE NOT clave_producto = "pzz" AND NOT ID_local = 2;

/* 2.4 IN */

SELECT * FROM ventas;

SELECT * FROM ventas WHERE clave_producto = "clz" OR "pzz" OR "qsd";

/* En este caso, solo discriminó por cls, ya que no se volvió a especificar la columna de la cual
queríamos extraer la información. Para hacer un filtro múltiple, hay que especificar la columna */

SELECT * FROM ventas WHERE clave_producto = "clz" OR clave_producto = "pzz" OR clave_producto = "qsd";

/* Pero también se puede hacer así...*/

SELECT * FROM ventas WHERE clave_producto IN ("clz", "pzz", "qsd");

/* Acá estoy diciendo que se extraigan los valores que se encuentran en las claves de producto especificadas. */

SELECT * FROM ventas WHERE ID_local IN (1, 2, 3);

SELECT * FROM ventas WHERE ID_local IN (1, 2, 3) AND clave_producto = "pzz";

SELECT * FROM ventas WHERE ID_local IN (1, 2, 3) AND clave_producto IN ("clz", "pzz");

/* 2.5. BETWEEN */

SELECT * FROM ventas;

/* Este permite definir rangos. */

SELECT * FROM ventas WHERE venta >= 500 AND venta < 1000;

SELECT * FROM ventas WHERE venta BETWEEN 500 AND 1000;

/* Between es incluyente. Es decir, es como un rango de tipo []. Se usa por ejemplo en este caso, 
para no estar definiendo varias veces la misma columna. Debe ir acompañado con un AND*/

/* 2.6. LIKE */

/* Sirve para buscar cosas que no conocemos muy bien. Permite busquedas inexactas */

SELECT * FROM ventas WHERE clave_producto LIKE "%z";

/* Poner el porcentaje "%"  permite identificar eso que se está buscando dentro de una palabra específica. Representa 0, 1 o múltiples caracteres. 
Si se pone antes de lo que se quiere buscar, indica que hay caracteres antes, si se pone después de lo que se quiere buscar, indica que hay caracteres después-*/

SELECT * FROM ventas WHERE clave_producto LIKE "z%"; /* En este caso, no aparece nada porque nada tiene caracteres después de la z" */

/* Si quiero hacer una busqeda donde sepamos que un caracter está en una posición específica ...*/

SELECT * FROM ventas WHERE clave_producto LIKE "_z";

/* En este caso, no sirvió porque estamos diciendo que lo último que hay es z */

SELECT * FROM ventas WHERE clave_producto LIKE "_z_";

/* Usar "%" tambi´pen serviría en este caso (_z%) */

SELECT * FROM empleados;
SELECT * FROM EMPLEADOS WHERE nombre like ("a%");

/* 2.7. EXPRESIONES REGULARES */

/* Se usa cuando se requiere filtrar un texto con características muy específicas */

SELECT * FROM empleados WHERE apellido LIKE ("%ez");

SELECT * FROM empleados WHERE apellido REGEXP "e";

/* Trae cualquier registro que tenga el caracter que buscamos, no importa donde.
El caracter "^" me permite especificar que lo que busco está al inicio */

SELECT * FROM empleados WHERE apellido REGEXP ("^B");
SELECT * FROM empleados WHERE apellido REGEXP ("ez$");

/* El operador "|" me permite poner varias condiciones*/

SELECT * FROM empleados WHERE apellido REGEXP ("ez|iz");

/* 2.8. ORDER BY */

SELECT * FROM empleados;

/* Podemos odernar los datos de forma ascendente o descendente si se toca el título de la columna.
Podemos hacer esto pero para que se ejcute en el query, debe hacerse con una fuinción*/

SELECT * FROM empleados ORDER BY Nombre;

/* Si quiero que lo haga de forma descendente, le pongo un DESC al final*/

SELECT * FROM empleados ORDER BY nombre DESC;

/* Que pasa si quiero mezclar filtros y ordenes. SIEMPRE primero se escfribe el WHERE */

SELECT * FROM empleados WHERE apellido LIKE "%ez" ORDER BY edad DESC;

/* Igual que con el SELECT, se puede ordenar por más de un parámetro, pero el orden en el que se escriben será el orden en el que se organizan los datos*/

SELECT * FROM empleados WHERE Apellido LIKE "%ez" ORDER BY Apellido, edad DESC;

/* 2.9. IS NULL */

/* Es un comando especial, que me permite ver o no, filas que tengan el espacio que yo indico, nulo, es decir, SIN DATOS, VACÍA*/

SELECT * FROM empleados;
SELECT * FROM empleados WHERE domicilio IS NULL;
SELECT * FROM empleados WHERE domicilio IS NOT NULL;

/* LIMIT */

/* Es como un Head en Python */

SELECT * FROM empleados LIMIT 5;

/* Si coloco un LIMIT a,b, me dará las columnas después de la a, y me mostrará b columnas */

SELECT * FROM empleados LIMIT 5,9;

/* EJERCICIOS*/

