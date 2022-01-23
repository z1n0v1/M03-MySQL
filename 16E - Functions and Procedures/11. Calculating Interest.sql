## From 11. Calculating Interest

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

# 11. Calculating Interest

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest DECIMAL(19,4))
BEGIN
	SELECT ac.id AS 'account_id', ah.first_name, ah.last_name, ac.balance AS 'current_balance',
			ufn_calculate_future_value(ac.balance, interest, 5)
		FROM accounts AS ac
		JOIN account_holders AS ah ON ah.id = ac.account_holder_id
		WHERE ac.id = acc_id;
END
$$
DELIMITER ;
DROP PROCEDURE IF EXISTS usp_calculate_future_value_for_account;
CALL usp_calculate_future_value_for_account(1, 0.1);
