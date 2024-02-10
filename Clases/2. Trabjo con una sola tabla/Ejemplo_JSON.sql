USE datos;
SELECT * FROM datos.productos;

UPDATE productos
SET caracteristicas = JSON_OBJECT("dimension",JSON_ARRAY(40,4,20),"producto",JSON_ARRAY("burrito","nachos"),"cantidad",2)
WHERE productos_id = 5;

UPDATE productos
SET caracteristicas = '{"dimension":[2,2,4],"producto":["tacos","enchiladas"],"cantidad":2}'
WHERE productos_id = 6;

UPDATE productos
SET caracteristicas = JSON_SET(caracteristicas, "$.cantidad",5);

/* En este caso, se actualizaron las cantidades de todos los objetos JSON, ya que no se especificó el WHERE*/

/* Se puede eliminar un valor de mi JSON, e igualmente, si no especifico mi fila, lo eliminará de todas */

UPDATE productos
SET caracteristicas = JSON_REMOVE(caracteristicas,"$.cantidad");

/* Para cambiar los datos de un ARRAY, toca usar la función de JSON_ARRAY después de seleccionar el valor deseado */

UPDATE productos
SET caracteristicas = JSON_SET(caracteristicas,"$.producto",JSON_ARRAY("pizza","burrito","quesadilla"))
WHERE productos_id = 6;