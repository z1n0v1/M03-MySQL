SELECT c.country_name, r.river_name
	FROM continents AS cn
	JOIN countries AS c USING(continent_code)
    LEFT JOIN countries_rivers AS cr USING(country_code)
    LEFT JOIN rivers AS r ON r.id = cr.river_id
    WHERE cn.continent_name = 'Africa'
    ORDER BY c.country_name
    LIMIT 5;