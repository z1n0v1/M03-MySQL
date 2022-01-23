SELECT country_name, iso_code FROM countries WHERE lower(country_name) LIKE "%a%a%a%" ORDER BY iso_code;

# Second solution :

SELECT country_name, iso_code FROM countries WHERE
	char_length(country_name) - char_length(replace(lower(country_name), 'a', '')) >= 3 ORDER BY iso_code;