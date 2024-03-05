USE proveedores;

/* 1. Introducción */

SELECT*
FROM pago_orden
JOIN orden
	ON orden.Orden = pago_orden.Orden;pago_after_insert

/* 2. Creación de Triggers */

-- También usaremos delimitadores, ya que hará varias funciones

DELIMITER $$

CREATE TRIGGER pago_after_insert
	AFTER INSERT ON pago_orden
    FOR EACH ROW
    
BEGIN
	UPDATE orden
    SET balance = balance + NEW.cantidad
    WHERE orden = NEW.orden;
END $$

DELIMITER ;

SELECT*
FROM pago_orden;

INSERT INTO pago_orden
VALUES(default, CURDATE(), 499, 6792, 100); --

SELECT*
FROM pago_orden;

/* 3. Modificar y borrar Triggers */

