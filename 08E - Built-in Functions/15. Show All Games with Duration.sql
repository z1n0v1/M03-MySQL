SELECT
    name AS game,
    IF(HOUR(start) < 12,
        'Morning',
        IF(HOUR(start) < 18,
            'Afternoon',
            'Evening')) AS 'Part of the Day',
    IF(duration <= 3,
        'Extra Short',
        IF(duration <= 6,
            'Short',
            IF(duration <= 10, 'Long', 'Extra Long'))) AS 'Duration'
FROM
    games;

### Alternative :

 SELECT
    `name` AS 'game',
    CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    `games`
ORDER BY `name`;