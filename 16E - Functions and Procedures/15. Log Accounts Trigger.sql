CREATE TABLE logs (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    old_sum DECIMAL(19,4) NOT NULL,
    new_sum DECIMAL(19,4) NOT NULL
);

DELIMITER $$
CREATE TRIGGER tr_transaction_log
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs SET account_id = old.id, old_sum = old.balance,
		new_sum = (SELECT balance FROM accounts WHERE id = old.id);
END
$$
 DELIMITER ;

DROP TRIGGER tr_transaction_log;
call usp_transfer_money(1,2,10);
SELECT * FROM logs;
