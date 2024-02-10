USE practicas;

SELECT*
FROM producto;

INSERT INTO producto(producto)
VALUES ("producto1"),("producto2");

UPDATE producto
SET producto = "Departamento"
WHERE producto = "producto2";

DELETE FROM producto
WHERE id_producto BETWEEN 8 AND 9;