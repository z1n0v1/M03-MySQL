SELECT
		hw.first_name AS 'host_wizard',
        hw.deposit_amount AS 'host_wizard_deposit',
        gw.first_name AS 'guest_wizard',
        gw.deposit_amount AS 'guest_wizard',
        (hw.deposit_amount - gw.deposit_amount) AS 'difference'
	FROM wizzard_deposits AS hw, wizzard_deposits as gw
    WHERE hw.id + 1 = gw.id
    ORDER BY hw.id;

SELECT sum((hw.deposit_amount - gw.deposit_amount)) AS sum_difference
	FROM wizzard_deposits AS hw, wizzard_deposits as gw
    WHERE hw.id + 1 = gw.id;