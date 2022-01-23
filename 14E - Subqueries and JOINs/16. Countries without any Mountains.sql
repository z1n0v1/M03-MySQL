SELECT count(c.country_code)
	FROM countries AS c
    LEFT JOIN mountains_countries as mc USING(country_code)
    WHERE mc.mountain_id IS NULL;