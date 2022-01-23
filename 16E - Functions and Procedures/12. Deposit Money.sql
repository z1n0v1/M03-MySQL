DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF ((SELECT count(a.id) FROM accounts as a WHERE a.id = account_id) != 1 OR money_amount < 0)
		THEN ROLLBACK;
		ELSE
			UPDATE accounts set balance = balance + money_amount WHERE id = account_id;
			COMMIT;
	END IF;
END
$$
DELIMITER ;