select (
        select avg(cnt)
        from (
                select id_town, count(*) as cnt
                from adress
                group by
                    id_town
            ) as par_commune
    ) as avg_adress_par_commune,
    (
        select avg(cnt)
        from (
                select id_lane, count(*) as cnt
                from adress
                group by
                    id_lane
            ) as par_voie
    ) as avg_adresses_par_voie;

SELECT id_town, COUNT(*) AS nb_repetition
FROM adress a
GROUP BY
    id_town
ORDER BY nb_repetition DESC
LIMIT 10;

SELECT a.*, t.name AS town_name, t.postcode, l.name AS lane_name
FROM adress a
    JOIN town t ON t.id = a.id_town
    JOIN lane l on l.id = a.id_lane
WHERE
    a.number IS NULL
    OR t.name IS NULL
    OR t.postcode IS NULL
    OR l.name IS NULL;