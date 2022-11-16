DROP PROCEDURE IF EXISTS delete_sauvegarde;
DELIMITER $$
CREATE PROCEDURE delete_sauvegarde(IN _id_sauvegarde INT)
BEGIN
	DELETE FROM sauvegarde WHERE id=_id_sauvegarde;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS nom_sauvegarde_trigger;
DELIMITER $$
CREATE TRIGGER nom_sauvegarde_trigger BEFORE INSERT ON sauvegarde FOR EACH ROW
BEGIN
	DECLARE _count_sauvegarde INT;
	# Si tu trouve qqc comme le nouveau Nom, ajoute un chiffre
	SET _count_sauvegarde = (
		SELECT COUNT(nom) FROM sauvegarde WHERE nom RLIKE CONCAT('(^', NEW.nom, '$)|(^', NEW.nom, '\\(\\d+\\)$)')
	);
	IF _count_sauvegarde > 0 THEN
		SET NEW.nom = CONCAT(NEW.nom, "(", _count_sauvegarde, ")");
	END IF;
END$$
DELIMITER ;