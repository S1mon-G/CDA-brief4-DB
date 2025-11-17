SELECT * FROM adress WHERE id_town = ? ORDER BY id_lane;

SELECT id_town, COUNT(*) AS number_of_adresses
FROM adress
GROUP BY
    id_town;

SELECT DISTINCT id_town AS different_towns FROM adress;

SELECT a.*, l.name
FROM adress a
    join lane l on a.id_lane = l.id
WHERE
    name ILIKE '%rue%';

SELECT a.*, t.postcode, t.name
FROM adress a
    join town t on a.id_town = t.id
WHERE
    t.postcode IS NULL
    AND t.name IS NOT NULL;