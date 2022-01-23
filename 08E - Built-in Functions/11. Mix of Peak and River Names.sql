SELECT
    p.peak_name,
    r.river_name,
    LOWER(CONCAT(p.peak_name, SUBSTRING(r.river_name, 2))) AS mix
FROM
    peaks AS p,
    rivers AS r
WHERE
    LOWER(LEFT(r.river_name, 1)) = LOWER(RIGHT(p.peak_name, 1))
ORDER BY mix;
