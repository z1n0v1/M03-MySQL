DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(start_with VARCHAR(20))
BEGIN
	SELECT name AS 'town_name' FROM towns WHERE left(LOWER(name), char_length(start_with)) = lower(start_with)
		ORDER BY town_name;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS usp_get_towns_starting_with;

CALL usp_get_towns_starting_with('b');