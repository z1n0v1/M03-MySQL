DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value (sum DECIMAL(19,4), interest DECIMAL(19,4), num_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN sum * (pow((1 + interest), num_years));
END
$$
DELIMITER ;
SELECT ufn_calculate_future_value(1000, 0.5, 5);