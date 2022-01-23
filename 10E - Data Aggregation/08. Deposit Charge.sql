SELECT deposit_group, magic_wand_creator, round(min(deposit_charge), 2) as 'min_deposit_charge'
    FROM  wizzard_deposits
	GROUP BY deposit_group, magic_wand_creator
    ORDER BY magic_wand_creator, deposit_group;