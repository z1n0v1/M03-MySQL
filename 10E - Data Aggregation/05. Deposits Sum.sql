SELECT deposit_group, round(sum(deposit_amount), 2) AS 'total_sum' FROM wizzard_deposits
	GROUP BY deposit_group ORDER BY `total_sum`;