USE proveedores;

/* 1. Introducción */

SELECT*
FROM pago_orden
JOIN orden
	ON orden.Orden = pago_orden.Orden;

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
    
    INSERT INTO auditoria_pagos
	VALUES(NEW.ID_pago, NEW.Orden, NEW.Fecha, NEW.Cantidad, "INSERT", CURDATE());
    
END $$

DELIMITER ;

SELECT*
FROM pago_orden;

SET SQL_SAFE_UPDATES = 0;

INSERT INTO pago_orden
VALUES(CURDATE(), 500, 6793, 100);

SELECT*
FROM pago_orden;

/* 3. Modificar y borrar Triggers */

SHOW TRIGGERS;

DROP TRIGGER pago_after_insert; -- Cuando esté creado, esta es la mejor manera de borrarlo

/* 4. Triggers como Auditoria */

SELECT * FROM auditoria_pagos;

INSERT INTO pago_orden
VALUES(CURDATE(), 502, 6793, 200);

SELECT *
FROM orden;

-- En los trigers todo es automático, por lo cual no deja evidencia, hay que crear una tabla de auditoría para poder hacer seguimiento

/* 5. Eventos */

/*

Son triggers que se ejecutan de forma periódica.

Sirven por ejemplo para evitar el consumo de almacenamiento con información muy vieja

*/

SHOW VARIABLES LIKE "event%" -- Si estuviera apagado tocaría hacer:

-- SET GLOBAL event.scheduler = ON;

DELIMITER $$

CREATE EVENT anual_borrar_filas_auditoria -- Usar la primera palabra mejor como periodicidad del evento

ON SCHEDULE 
	EVERY 1 YEAR STARTS "2023-12-25" ENDS "2026-12-25"
    
DO BEGIN
	DELETE FROM auditoria_pagos
    WHERE fecha < NOW()-INTERVAL 1 YEAR;
    
END $$

DELIMITER ;

SHOW EVENTS;

DROP EVENT IF EXISTS anual_borrar_filas_auditoria;
