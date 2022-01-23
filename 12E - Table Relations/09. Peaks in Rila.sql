SELECT m.mountain_range, p.peak_name, p.elevation AS 'peak_elevation'
	FROM peaks AS p
	JOIN mountains AS m ON m.id = p.mountain_id
    WHERE m.mountain_range = 'Rila'
    ORDER BY p.elevation DESC;