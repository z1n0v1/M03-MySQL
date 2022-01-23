DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF((SELECT count(a.id) FROM accounts as a WHERE a.id = account_id) != 1 OR
		money_amount < 0 OR
        (SELECT balance FROM accounts WHERE id = account_id) < money_amount)
        THEN ROLLBACK;
        ELSE
			UPDATE accounts SET balance = balance - money_amount WHERE id = account_id;
            COMMIT;
		END IF;
END
$$
DELIMITER ;
