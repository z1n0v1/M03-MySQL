SELECT starting_point as 'route_starting_point', end_point as 'route_ending_point',
	leader_id, 	concat_ws(' ', first_name, last_name) as leader_name
    FROM routes AS r JOIN campers AS c ON r.leader_id = c.id;