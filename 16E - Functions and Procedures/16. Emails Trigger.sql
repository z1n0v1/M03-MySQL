SELECT date_format(current_timestamp(), '%b %e %Y at %l:%i:%s %p');

CREATE TABLE notification_emails (
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT NOT NULL,
    subject VARCHAR(100),
    body TEXT
);

DELIMITER $$
CREATE TRIGGER tr_notification_emails
BEFORE INSERT
ON logs
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails SET
			recipient = new.account_id,
            subject = concat('Balance change for account: ', new.account_id),
            body = concat('On ', date_format(current_timestamp(), '%b %e %Y at %l:%i:%s %p'),
					'AM your balance was changed from ', new.old_sum,
                    ' to ', new.new_sum, '.');

END
$$
DELIMITER ;

SELECT * FROM notification_emails;