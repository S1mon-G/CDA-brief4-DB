SELECT
    a.number,
    l.name AS lane_name,
    t.postcode,
    t.name as town_name,
    COUNT(*) AS nb_repetition
FROM adress a
    JOIN lane l on l.id = a.id_lane
    JOIN town t on t.id = a.id_town
GROUP BY
    a.number,
    l.name,
    t.postcode,
    t.name
HAVING
    COUNT(*) > 1;

SELECT *
FROM adress a
    JOIN coordinates c ON c.id = a.id_coordinates
WHERE
    c.x is null
    OR c.y is null
    OR c.lon is null
    OR c.lat is null;

SELECT id_town, COUNT(*) AS nb_repetition
FROM adress a
GROUP BY
    id_town
HAVING
    COUNT(*) > 10000;