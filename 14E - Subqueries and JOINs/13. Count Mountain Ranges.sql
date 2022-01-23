SELECT mc.country_code, COUNT(mc.mountain_id) AS 'mountain_range'
	FROM mountains_countries AS mc
	JOIN countries AS c USING(country_code)
	WHERE c.country_name IN ('United States', 'Russia', 'Bulgaria')
	GROUP BY country_code
	ORDER BY `mountain_range` DESC;