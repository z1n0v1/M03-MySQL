SELECT DISTINCT
		left(first_name, 1) AS 'first_letter'
	FROM wizzard_deposits
    WHERE deposit_group = 'Troll Chest'
    ORDER BY `first_letter`;

# Alternative solution :

SELECT
		left(first_name, 1) AS 'first_letter'
	FROM wizzard_deposits
    WHERE deposit_group = 'Troll Chest'
    GROUP BY `first_letter`
    ORDER BY `first_letter`;