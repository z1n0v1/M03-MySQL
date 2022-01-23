SELECT name, date_format(start, '%Y-%m-%d') as start
    FROM games WHERE year(start) in (2011, 2012)
    ORDER BY start, name LIMIT 50;