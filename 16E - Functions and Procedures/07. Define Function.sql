DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS bit
DETERMINISTIC
BEGIN
	RETURN word REGEXP (concat('^[',set_of_letters,']*$'));
END
$$
DELIMITER ;

SELECT ufn_is_word_comprised('asdf', 'safd');
SELECT ufn_is_word_comprised('asdf', 'csafd');